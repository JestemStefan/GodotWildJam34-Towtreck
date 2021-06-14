extends Spatial

var orbital_speed: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	rotate_y(orbital_speed * delta)
