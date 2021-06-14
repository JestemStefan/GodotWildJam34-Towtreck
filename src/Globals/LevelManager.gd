extends Node

var current_sun = null

var orbit_instance = preload("res://Scenes/CelestialBodies/Orbit.tscn")
var occupied_orbits: Array = []

var orbit_spacing: float = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# check if this orbit is free and return planet orbital spot or null
func get_free_orbit(planet) -> Position3D:
	
	# get orbit radious
	var requested_orbit_r: float = round(current_sun.global_transform.origin.distance_to(planet.global_transform.origin))
	
	# check if this orbit is already occupied
	for orbit_r in occupied_orbits:
		
		# if distance too other orbit is too small then orbit is occupied
		if abs(orbit_r - requested_orbit_r) < orbit_spacing:
			print("This orbit is occupied. Move planet somehwere else")
			return null
	
	# if not then it's free.
	# add to list of occupied orbits and return true
	occupied_orbits.append(requested_orbit_r)
	print(occupied_orbits)
	
	# create new orbital spot and return
	return create_new_orbit_spot(planet.global_transform.origin)



func create_new_orbit_spot(planet_pos: Vector3) -> Position3D:
	
	# create new position that planets will follow
	var orbit = orbit_instance.instance()
	var orbit_spot = Position3D.new()
	
	# add orbit in game world
	current_sun.get_node("Orbits").add_child(orbit)
	
	# set orbital period based on distance 
	orbit.orbital_speed  = 1000 / pow(current_sun.global_transform.origin.distance_to(planet_pos), 2)
	
	# add orbital spot on this orbit
	orbit.add_child(orbit_spot)
	
	# place spot at requested position
	orbit_spot.global_transform.origin = planet_pos
	
	return orbit_spot



func release_orbit(orbital_spot: Position3D):
	
	# should I check if orbit is on the list?
	
	# delete orbit from the list so it will became available
	var orbit_r: float = round(current_sun.global_transform.origin.distance_to(orbital_spot.global_transform.origin))
	occupied_orbits.erase(orbit_r)
	
	# delete orbit and orbital spot
	orbital_spot.get_parent().call_deferred("free")
