extends Camera

onready var player = $"../Player"

func _physics_process(delta):
	translation.x = player.translation.x
	translation.z = player.translation.z + 60
