extends KinematicBody2D

export var speed = 20.0
export var turnSpeed = 2.0
export var velocityFall = 2.0

var velocity = Vector2.ZERO
var turn = 0
onready var flame = $Sprite/AnimatedSprite;

func _process(delta: float):
	if Input.is_action_just_pressed("thrust_forwards"):
		flame.play()
		flame.show()
	if Input.is_action_just_released("thrust_forwards"):
		flame.hide()
		flame.stop()

func _physics_process(delta: float):
	var turnChange = (Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")) * delta * turnSpeed
	turn += turnChange
	rotation = turn
	
	var direction = Vector2(0, Input.get_action_strength("thrust_backwards") - Input.get_action_strength("thrust_forwards")).rotated(turn) * speed
	
	velocity += direction;
	move_and_slide(velocity);
	velocity -= velocity * delta * velocityFall

func _unhandled_input(event: InputEvent):
	if event.is_echo():
		return
