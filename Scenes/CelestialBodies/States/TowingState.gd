extends State

var trailer: TrailerBase

func OnStateLoad(parameters: Array):
	trailer = parameters[0]
	
func OnStateUnload():
	pass
	
func Process(delta: float):
	pass
	
func PhysicsProcess(delta: float):
	var vector = trailer.global_transform.origin - global_transform.origin
	if vector.length() < 5:
		target.translation = trailer.translation
	else:
		(target as KinematicBody).move_and_slide(vector * 10)
	
func Draw():
	pass
	
func Input(event: InputEvent):
	pass
