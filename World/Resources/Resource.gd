extends Spatial

class_name GameResource

export var color: Color
export var resourceType: String

func _ready():
	$OmniLight.light_color = color
	add_to_group("resources")
