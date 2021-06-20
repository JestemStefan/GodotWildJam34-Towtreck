extends Spatial

onready var confetti_instance: PackedScene = preload("res://art/Confetti/Confetti.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var confetti: Node2D = confetti_instance.instance()
	add_child(confetti)
	confetti.play_loop()
