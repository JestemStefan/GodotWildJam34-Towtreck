extends Spatial
class_name State

var stateMachine
var target: Node
var isCurrent: bool

export(String) var stateType
export(bool) var isDefault

func OnStateLoad(parameters: Array):
	assert(false, "Please override `OnStateLoad()` in state script.")
	
func OnStateUnload():
	assert(false, "Please override `OnStateUnload()` in state script.")
	
func Process(delta: float):
	assert(false, "Please override `Process()` in state script.")
	
func PhysicsProcess(delta: float):
	assert(false, "Please override `PhysicsProcess()` in state script.")
	
func Draw():
	assert(false, "Please override `Draw()` in state script.")
	
func Input(event: InputEvent):
	assert(false, "Please override `Input()` in state script.")
	
func OnStateLoadBase(parameters: Array):
	isCurrent = true
	OnStateLoad(parameters)
	
func OnStateUnloadBase():
	isCurrent = false
	OnStateUnload()
	
func ProcessBase(delta: float):
	if isCurrent:
		Process(delta)
		
func PhysicsProcessBase(delta: float):
	if isCurrent:
		PhysicsProcess(delta)
		
func DrawBase():
	if isCurrent:
		Draw()
		
func InputBase(event: InputEvent):
	if isCurrent:
		Input(event)
