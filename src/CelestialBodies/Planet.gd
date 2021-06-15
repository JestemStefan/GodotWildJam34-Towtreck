extends CelestialBody
class_name Planet

# Planet stats
export var planet_weight: float = 1


func _ready():
	add_to_group("celestial_bodies", true)
	update_size()


func _process(delta):
	$PlanetsSurface.rotate_y(0.1 * delta)
	$Clouds.rotate_y(0.2 * delta)


func grow_planet():
	planet_weight += 0.5 + (planet_weight * 0.01)
	update_size()


func shrink_planet():
	planet_weight -= 0.5 + (planet_weight * 0.01)
	update_size()


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
