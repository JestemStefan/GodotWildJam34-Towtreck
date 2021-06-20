extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_once():
	$Label.show()
	for ps in get_children():
		if ps is CPUParticles2D:
			if (ps as CPUParticles2D).emitting == false:
				(ps as CPUParticles2D).emitting = true
	
	if is_instance_valid(self):
		yield(get_tree().create_timer(5.0), "timeout")
	
	for ps in get_children():
		if ps is CPUParticles2D:
			ps.call_deferred("free")


func play_loop():
	$Label.hide()
	for ps in get_children():
		if ps is CPUParticles2D:
			if (ps as CPUParticles2D).emitting == false:
				(ps as CPUParticles2D).emitting = true
