extends Area

var markerType = 8

func _ready():
	add_to_group("minimap_targets", true)

func _process(delta):
	rotate_y(delta)


func _on_SunArea_body_entered(body):
	if body is Sun:
		LevelManager.sun_placed()
		$MeshInstance.hide()


func _on_SunArea_body_exited(body):
	if body is Sun:
		LevelManager.sun_taken()
		$MeshInstance.show()
