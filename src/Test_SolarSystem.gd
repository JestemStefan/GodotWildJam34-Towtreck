extends Spatial

onready var planet_instance = preload("res://art/planet/Planet_v1.tscn")

var planet: Planet

# Called when the node enters the scene tree for the first time.
func _ready():
	planet = planet_instance.instance()
	add_child(planet)


func _process(delta):
	#planet_weight *= sqrt(1.01)
	if Input.is_action_pressed("ui_home"):
		planet.grow_planet()
	
	if Input.is_action_pressed("ui_end"):
		planet.shrink_planet()
	
	
