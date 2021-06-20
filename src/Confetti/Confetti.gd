extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_once():
	for ps in get_children():
		(ps as CPUParticles2D).emitting = true
	
	yield(get_tree().create_timer(5), "timeout")
	
	call_deferred("free")


func play_loop():
	for ps in get_children():
		(ps as CPUParticles2D).emitting = true
