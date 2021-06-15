extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



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
