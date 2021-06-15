extends CelestialBody
class_name Sun

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.current_sun = self
	add_to_group("celestial_bodies", true)

func unhook_from_ship():
	.unhook_from_ship()
	stateMachine.SetState("stationary")
