extends CelestialBody
class_name Planet

# Planet stats
export var planet_weight: float = 1

var materialWeight: int = 0
var iceWeight: int = 0
var rocksWeight: int = 0
var hydrogenWeight: int = 0

var markerType = 1

func _ready():
	add_to_group("celestial_bodies", true)
	add_to_group("minimap_targets", true)
	update_size()


func _process(delta):
	$PlanetsSurface.rotate_y(0.1 * delta)
	$Clouds.rotate_y(0.2 * delta)
	
	$PlanetStats.rect_position = get_viewport().get_camera().unproject_position(global_transform.origin)
	if LevelManager.current_sun != null:
		$PlanetStats.text = str(global_transform.origin.distance_to(LevelManager.current_sun.global_transform.origin))


func grow_planet(resourceCloud: GameResource):
	planet_weight += 0.5 + (planet_weight * 0.01)
	update_size()
	
	materialWeight += 1
	match resourceCloud.CloudType:
		1:
			hydrogenWeight += 1
		2:
			rocksWeight += 1
		3:
			iceWeight += 1
	
	print(materialWeight, " ", hydrogenWeight, " ", rocksWeight, " ", iceWeight)


func shrink_planet(resourceCloud: GameResource):
	match resourceCloud.CloudType:
		1:
			if hydrogenWeight < 1:
				return
			hydrogenWeight -= 1
		2:
			if rocksWeight < 1:
				return
			rocksWeight -= 1
		3:
			if iceWeight < 1:
				return
			iceWeight -= 1
	
	materialWeight -= 1
	planet_weight -= 0.5 + (planet_weight * 0.01)
	update_size()
	
	print(materialWeight, " ", hydrogenWeight, " ", rocksWeight, " ", iceWeight)


func update_size():
	if planet_weight > 1:
		self.scale = Vector3.ONE * (pow(0.75 * planet_weight, 0.3))
	
	else:
		planet_weight = 1
		self.scale = Vector3.ONE

# try to put planet in orbit
func unhook_to_orbit() -> int:
	
	# get empty parking spot
	var orbital_parking_spot = LevelManager.get_free_orbit(self)
	
	# if there is no empty spot in this place then eturn null
	if orbital_parking_spot == null:
		return FAILED
	
	# else place planet in orbit
	stateMachine.SetState("orbitting", false, [orbital_parking_spot])
	return OK
