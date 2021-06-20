extends CelestialBody
class_name Sun

var markerType = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.current_sun = self
	add_to_group("celestial_bodies", true)
	add_to_group("minimap_targets", true)

func unhook_from_trailer():
	.unhook_from_trailer()
	stateMachine.SetState("stationary")
	return OK
