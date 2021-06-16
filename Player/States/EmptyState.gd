extends State

const VectorUtils = preload("res://Utils/VectorUtils.gd")

func OnStateLoad(parameters: Array):
	pass

func OnStateUnload():
	pass

func Process(delta: float):
	if Input.is_action_just_pressed("select"):
		if target.nearbyTrailer != null:
			target.nearbyTrailer.AttachToShip(target)
			stateMachine.SetState("towing", false, [target.nearbyTrailer])

func PhysicsProcess(delta: float):
	pass

func Draw():
	pass

func Input(event: InputEvent):
	pass

