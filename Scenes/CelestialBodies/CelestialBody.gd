extends KinematicBody
class_name CelestialBody

export var speed: float = 6.0
export var velocityFall: float = 4.0
export var playerDistance: float = 50.0

onready var stateMachine: StateMachine = $StateMachine

func _on_area_body_entered(body):
	if body is Player:
		body.CelestialAreaEntered(self)

func _on_area_body_exited(body):
	if body is Player:
		body.CelestialAreaExited(self)

func hook_to_ship(ship: Player):
	$CollisionShape.disabled = true
	stateMachine.SetState("towing", false, [ship])
	
func unhook_from_ship():
	$CollisionShape.disabled = false
