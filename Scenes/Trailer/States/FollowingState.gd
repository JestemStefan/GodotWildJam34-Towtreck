extends State

var ship: Player
var velocity = Vector3.ZERO
var firstInputIgnored: bool

func OnStateLoad(parameters: Array):
	velocity = Vector3.ZERO
	ship = parameters[0]
	firstInputIgnored = parameters[1]
	
func OnStateUnload():
	pass
	
func Process(delta: float):
	if Input.is_action_just_pressed("select"):
		if !firstInputIgnored:
			firstInputIgnored = true
		else:
			stateMachine.SetState("stationary")
	
func PhysicsProcess(delta: float):
	var distance = (ship.global_transform.origin - target.global_transform.origin).length()
	if distance > target.playerDistance:
		var direction = self.global_transform.origin.direction_to(ship.global_transform.origin)
		velocity += direction * target.speed
	
	velocity = target.move_and_slide(velocity)
	velocity -= velocity * delta * target.velocityFall
	
func Draw():
	pass
	
func Input(event: InputEvent):
	pass
