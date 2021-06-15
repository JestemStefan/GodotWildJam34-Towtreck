extends State

var orbital_parking_spot: Position3D = null

func OnStateLoad(parameters: Array):
	orbital_parking_spot = parameters[0]
	
func OnStateUnload():
	orbital_parking_spot = null
	
func Process(delta: float):
	pass
	
func PhysicsProcess(delta: float):
	target.global_transform.origin = orbital_parking_spot.global_transform.origin
	
func Draw():
	pass
	
func Input(event: InputEvent):
	pass
