extends Spatial


export var gate_rotation_speed: float = 1

var isEnabled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _process(delta):
	
		
	if isEnabled:
		$Warpgate_Main.rotate_z(gate_rotation_speed * delta * 2)
		$Warpgate_second.rotate_z(gate_rotation_speed * -delta * 3)
		$Warpgate_third.rotate_z(gate_rotation_speed * delta * 4)
		
		if Input.is_action_just_pressed("select"):
			get_tree().change_scene("res://World/TestEnvironment.tscn")

func enable_warpgate():
	isEnabled = true
	$AnimationPlayer.play("Turn_On")


func disable_warpgate():
	isEnabled = false
	$AnimationPlayer.play("Turn_Off")


func _on_AnimationPlayer_animation_finished(anim_name):
	pass


func _on_Warpgate_body_entered(body):
	if body is Player:
		enable_warpgate()


func _on_Warpgate_body_exited(body):
	if body is Player:
		disable_warpgate()
