extends Spatial
class_name StateMachine

var states: Dictionary
var currentState: State
var currentStateType
var target: Node setget setTarget

func setTarget(value):
	target = value
	for state in states.values():
		state.Target = value

func _init(target: Node):
	setTarget(target)

func RegisterState(type, state: State, default = false):
	assert(!states.has(type), "State of this type already added")
	
	state.stateMachine = self
	state.target = target
	state.stateType = type
	states[type] = state
	
	if default:
		SetState(type, true)

func SetState(type, force = false, parameters = []):
	if !force && type != currentStateType:
		return
	
	var incomingState: State = states[type]
	if incomingState == null:
		return
	
	if currentState != null:
		remove_child(currentState)
		currentState.OnStateUnloadBase()
	
	currentState = incomingState
	currentStateType = type
	incomingState.OnStateLoadBase(parameters)
	
	add_child(currentState)

func _process(delta):
	if currentState != null:
		currentState.ProcessBase(delta)

func _physics_process(delta):
	if currentState != null:
		currentState.PhysicsProcessBase(delta)

func _draw():
	if currentState != null:
		currentState.DrawBase()

func _input(event):
	if currentState != null:
		currentState.InputBase(event)
