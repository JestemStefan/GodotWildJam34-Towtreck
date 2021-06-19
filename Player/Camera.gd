extends Camera

export var playerPath: NodePath

onready var player = get_node(playerPath)

func _physics_process(delta):
	translation.x = player.translation.x
	translation.z = player.translation.z + 60
