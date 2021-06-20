extends KinematicBody
class_name CelestialBody

export var speed: float = 6.0
export var velocityFall: float = 4.0
export var playerDistance: float = 50.0

onready var stateMachine: StateMachine = $StateMachine
onready var sfx_connect: AudioStreamSample = preload("res://Audio/SFX/GWJ34_CelstialConnect.wav")
onready var sfx_disconnect: AudioStreamSample = preload("res://Audio/SFX/GWJ34_CelstialDisconnect.wav")

func _on_area_body_entered(body):
	if body is Player:
		body.CelestialAreaEntered(self)

func _on_area_body_exited(body):
	if body is Player:
		body.CelestialAreaExited(self)

func hook_to_trailer(trailer):
	$CollisionShape.disabled = true
	AudioManager.play_sfx(sfx_connect)
	stateMachine.SetState("towing", false, [trailer])
	
func unhook_from_trailer():
	$CollisionShape.disabled = false
	AudioManager.play_sfx(sfx_disconnect)
	return OK
