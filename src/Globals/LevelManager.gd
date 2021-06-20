extends Node

var current_level: Node = null
var current_sun = null
var objectivesUI = null

var warp_to_hub = null

var orbit_instance = preload("res://Scenes/CelestialBodies/Orbit.tscn")
var occupied_orbits: Dictionary = {}

var levelBasePack = preload("res://src/Levels/LevelBase.tscn")
var sunPack = preload("res://Scenes/CelestialBodies/Sun.tscn")
var sunSpotPack = preload("res://Scenes/LevelElements/SunSpotArea.tscn")
var growingTrailerPack = preload("res://Scenes/Trailer/GrowingTrailer.tscn")
var resourceCloudPack = preload("res://World/Resources/Resource.tscn")

var orbit_spacing: float = 15

var isSunPlacedCorrectly: bool = false

var completedLevels = 0

var orbit_tasks: Array = []

var isConfettiReady: bool = true
onready var confetti_instance: PackedScene = preload("res://art/Confetti/Confetti.tscn")


func _process(delta):
	if !is_instance_valid(current_level) or current_level is HubWorld:
		return
	
	if is_instance_valid(objectivesUI):
		if objectivesUI.AllDone():
			warp_to_hub.enable()
			if isConfettiReady:
				isConfettiReady = false
				var confetti: Node2D = confetti_instance.instance()
				current_level.add_child(confetti)
				confetti.play_once()
			
		var percentDone = objectivesUI.PercentageDone()
		if percentDone >= 25:
			AudioManager.play_single_music_track(1)
		if percentDone >= 50:
			AudioManager.play_single_music_track(2)
		if percentDone >= 75:
			AudioManager.play_single_music_track(3)
			
	for planet in occupied_orbits:
		var orbit = occupied_orbits[planet]
		for template in orbit_tasks:
			if abs(template.orbit - orbit) < 10 and abs(planet.icePercent - template.icePercent) < 5 and abs(planet.rocksPercent - template.rocksPercent) < 5 and abs(planet.hydrogenPercent - template.hydrogenPercent) < 5:
				objectivesUI.SetObjective("planet_" + String(template.orbit), true)
	
	for template in orbit_tasks:
		var found = false
		for orbit in occupied_orbits.values():
			if abs(template.orbit - orbit) < 10:
				found = true
				break
		if !found:
			objectivesUI.SetObjective("planet_" + String(template.orbit), false)
	
# planets fields - orbit: float, rocksPercent: int, hydrogenPercent: int, icePercent: int
# resource clouds - arrays of positions
func SetupLevel(sunPosition: Vector2, sunSpotPosition: Vector2, planets: Array, hydrogenClouds: Array, rockClouds: Array, iceClouds: Array):
	current_level = null
	occupied_orbits.clear()
	orbit_tasks.clear()
	
	get_tree().change_scene("res://src/Levels/LevelBase.tscn")
	while current_level == null:
		yield(get_tree().create_timer(0.1), "timeout")
	
	var sun = sunPack.instance()
	sun.translation = Vector3(sunPosition.x, 0, sunPosition.y)
	current_level.add_child(sun)
	current_sun = sun
	
	var sunSpot = sunSpotPack.instance()
	sunSpot.translation = Vector3(sunSpotPosition.x, 0, sunSpotPosition.y)
	current_level.add_child(sunSpot)
	objectivesUI.AddObjective("sun", "Set the star in the correct spot")
	
	var trailer = growingTrailerPack.instance()
	trailer.translation = Vector3(10, 0, 10)
	current_level.add_child(trailer)
	
	for cloudPosition in hydrogenClouds:
		var cloud = resourceCloudPack.instance()
		cloud.translation = Vector3(cloudPosition.x, 0, cloudPosition.y)
		cloud.CloudType = 1
		current_level.add_child(cloud)
		
	for cloudPosition in rockClouds:
		var cloud = resourceCloudPack.instance()
		cloud.translation = Vector3(cloudPosition.x, 0, cloudPosition.y)
		cloud.CloudType = 2
		current_level.add_child(cloud)
	
	for cloudPosition in iceClouds:
		var cloud = resourceCloudPack.instance()
		cloud.translation = Vector3(cloudPosition.x, 0, cloudPosition.y)
		cloud.CloudType = 3
		current_level.add_child(cloud)
	
	for planetTemplate in planets:
		orbit_tasks.append(planetTemplate)
		objectivesUI.AddObjective("planet_" + String(planetTemplate.orbit), "Planet in orbit " + String(planetTemplate.orbit) + " (rocks: " + String(planetTemplate.rocksPercent) + "%, hydrogen: " + String(planetTemplate.hydrogenPercent) + "%, ice: " + String(planetTemplate.icePercent) + "%)")
		

# check if this orbit is free and return planet orbital spot or null
func get_free_orbit(planet) -> Position3D:
	
	# get orbit radious
	var requested_orbit_r: float = round(current_sun.global_transform.origin.distance_to(planet.global_transform.origin))
	
	# check if this orbit is already occupied
	for orbit_r in occupied_orbits.values():
		
		# if distance too other orbit is too small then orbit is occupied
		if abs(orbit_r - requested_orbit_r) < orbit_spacing:
#			print("This orbit is occupied. Move planet somehwere else")
			return null
	
	# if not then it's free.
	# add to list of occupied orbits and return true
	occupied_orbits[planet] = requested_orbit_r
	
	# create new orbital spot and return
	return create_new_orbit_spot(planet.global_transform.origin)


func create_new_orbit_spot(planet_pos: Vector3) -> Position3D:
	
	# create new position that planets will follow
	var orbit = orbit_instance.instance()
	var orbit_spot = Position3D.new()
	
	# add orbit in game world
	current_sun.get_node("Orbits").add_child(orbit)
	
	# set orbital period based on distance 
	orbit.orbital_speed  = 250 / pow(current_sun.global_transform.origin.distance_to(planet_pos), 2)
	
	# add orbital spot on this orbit
	orbit.add_child(orbit_spot)
	
	# place spot at requested position
	orbit_spot.global_transform.origin = planet_pos
	
	return orbit_spot


func release_orbit(orbital_spot: Position3D):
	
	# delete orbit from the list so it will became available
	var orbit_r: float = round(current_sun.global_transform.origin.distance_to(orbital_spot.global_transform.origin))
	
#	print_debug("orbit to release: " + str(orbit_r))
#	print_debug(occupied_orbits.values())
	for key in occupied_orbits:
		if occupied_orbits[key] == orbit_r:
			occupied_orbits.erase(key)
			break
	
	# delete orbit and orbital spot
	orbital_spot.get_parent().call_deferred("free")


func sun_placed():
	isSunPlacedCorrectly = true
	objectivesUI.SetObjective("sun", true)


func sun_taken():
	isSunPlacedCorrectly = false
	objectivesUI.SetObjective("sun", false)
	
