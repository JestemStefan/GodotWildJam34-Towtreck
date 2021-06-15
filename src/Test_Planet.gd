extends Spatial
class_name Planet

enum PlanetStates{FREE, TOWED, IN_ORBIT}
var current_state: int = PlanetStates.FREE

# Planet stats
export var planet_weight: float = 1

var orbital_parking_spot: Position3D = null


func _ready():
	add_to_group("celestial_bodies", true)
	update_size()


func _process(delta):
	$PlanetsSurface.rotate_y(0.1 * delta)
	$Clouds.rotate_y(0.2 * delta)
	
	match current_state:
		
		PlanetStates.FREE:
			pass
		
		PlanetStates.TOWED:
			pass
		
		PlanetStates.IN_ORBIT:
			global_transform.origin = orbital_parking_spot.global_transform.origin


func enter_state(new_state: int):
	
	current_state = new_state
	
	match current_state:
		PlanetStates.FREE:
			pass
		
		PlanetStates.TOWED:
			pass
		
		PlanetStates.IN_ORBIT:
			pass


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
	orbital_parking_spot = LevelManager.get_free_orbit(self)
	
	# if there is no empty spot in this place then eturn null
	if orbital_parking_spot == null:
		return FAILED
	
	# else place planet in orbit
	enter_state(PlanetStates.IN_ORBIT)
	return OK
	

func hook_to_ship():
	
	match current_state:
		
		PlanetStates.FREE:
			# enter towed state
			enter_state(PlanetStates.TOWED)
		
		PlanetStates.TOWED:
			push_error("Towing already hooked planets shouldn't be possible")
		
		PlanetStates.IN_ORBIT:
			# delete orbit
			LevelManager.release_orbit(orbital_parking_spot)
			
			# reset parking spot
			orbital_parking_spot = null
			
			# enter towed state
			enter_state(PlanetStates.TOWED)
		
	
	
