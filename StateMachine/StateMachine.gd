extends Node2D
class_name StateMachine

const StateClass = preload("res://StateMachine/State.gd")

var states: Dictionary
var currentState: State
var currentStateType
var target: Node setget setTarget

func setTarget(value):
	target = value
	for state in states.values():
		state.Target = value

func _ready():
	for node in get_children():
		if node is StateClass:
			RegisterState(node.stateType, node, node.isDefault)

func RegisterState(type, state: State, default = false):
	assert(!states.has(type), "State of this type already added")
	
	state.stateMachine = self
	state.target = target
	state.stateType = type
	states[type] = state
	
	if !get_children().has(state):
		add_child(state)
	
	if default:
		SetState(type, true)

func SetState(type, force = false, parameters = []):
	if !force && type != currentStateType:
		return
	
	var incomingState: State = states[type]
	if incomingState == null:
		return
	
	if currentState != null:
		currentState.OnStateUnloadBase()
	
	currentState = incomingState
	currentStateType = type
	incomingState.OnStateLoadBase(parameters)

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
