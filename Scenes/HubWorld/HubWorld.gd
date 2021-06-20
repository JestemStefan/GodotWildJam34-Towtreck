extends Spatial
class_name HubWorld

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.current_level = self


func rotate_background(rot: Vector3):
	$WorldEnvironment.environment.background_sky_rotation_degrees += Vector3(-rot.z, rot.y, rot.x) * 0.01
