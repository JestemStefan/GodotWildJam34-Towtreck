extends Spatial
class_name Sun


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.current_sun = self
	add_to_group("celestial_bodies", true)


func _on_SunArea_body_entered(body):
	if body is Player:
		pass


func _on_SunArea_body_exited(body):
	if body is Player:
		pass


func hook_to_ship():
	$CollisionShape.disabled = true
	

func unhook_from_ship():
	$CollisionShape.disabled = false
