extends State

var towingTarget: Spatial

func OnStateLoad(parameters: Array):
	towingTarget = parameters[0]
	
func OnStateUnload():
	pass
	
func Process(delta: float):
	if Input.is_action_just_pressed("select"):
		stateMachine.SetState("empty")
	
func PhysicsProcess(delta: float):
	var pivotRadius = Vector3.FORWARD * 5;
	var transform = Transform(towingTarget.transform.basis, target.translation)
	towingTarget.transform = transform.rotated(Vector3(0, 1, 0), delta).translated(pivotRadius)
	
func Draw():
	pass
	
func Input(event: InputEvent):
	pass
