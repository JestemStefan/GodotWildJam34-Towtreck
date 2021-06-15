extends KinematicBody
class_name Player

export var speed = 4.0
export var turnSpeed = 3.0
export var velocityFall = 2.0

var velocity = Vector3.ZERO
var turn = 0
var nearbyCelestialBody
var nearbyResourceCloud

func _physics_process(delta: float):
	var turnChange = (Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")) * delta * turnSpeed
	turn += turnChange
	rotation.y = turn
	
	var direction = Vector3(0, 0, Input.get_action_strength("thrust_backwards") - Input.get_action_strength("thrust_forwards")).rotated(Vector3.UP, turn) * speed
	
	velocity += direction
	velocity = move_and_slide(velocity);
	velocity -= velocity * delta * velocityFall

func _unhandled_input(event: InputEvent):
	if event.is_echo():
		return

func CelestialAreaEntered(object):
	nearbyCelestialBody = object;
	
func CelestialAreaExited(object):
	if nearbyCelestialBody == object:
		nearbyCelestialBody = null

func ResourceAreaEntered(object):
	nearbyResourceCloud = object
	
func ResourceAreaExited(object):
	if nearbyResourceCloud == object:
		nearbyResourceCloud = null
