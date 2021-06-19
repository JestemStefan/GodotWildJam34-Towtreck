extends Spatial

onready var minimap = $CanvasLayer/Minimap

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.current_level = self

func add_child(child: Node, legible_unique_name = false):
	.add_child(child, legible_unique_name)
	if child.is_in_group("minimap_targets"):
		minimap.AddMarker(child)
		
func remove_child(child: Node):
	.remove_child(child)
	if child.is_in_group("minimap_targets"):
		minimap.RemoveMarker(child)

func rotate_background(rot: Vector3):
	$WorldEnvironment.environment.background_sky_rotation_degrees += Vector3(rot.z, rot.y, -rot.x) * 0.01

