extends PathFollow
class_name MovingResource

export var color: Color;

func _ready():
	$MeshInstance.get_surface_material(0).albedo_color = color;
	
func _physics_process(delta):
	unit_offset = clamp(unit_offset + 0.025, 0, 1)
	
	if unit_offset == 1:
		queue_free()
