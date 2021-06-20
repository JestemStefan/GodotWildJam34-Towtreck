extends Spatial
class_name HubWorld

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.current_level = self
	
	if LevelManager.completedLevels > 0:
		$Warpgate2.show()
	if LevelManager.completedLevels > 1:
		$Warpgate3.show()
	if LevelManager.completedLevels > 2:
		$Warpgate4.show()
	if LevelManager.completedLevels > 3:
		get_tree().change_scene("res://art/EndGameScene/EndGameScene.tscn")

func rotate_background(rot: Vector3):
	$WorldEnvironment.environment.background_sky_rotation_degrees += Vector3(-rot.z, rot.y, rot.x) * 0.01
