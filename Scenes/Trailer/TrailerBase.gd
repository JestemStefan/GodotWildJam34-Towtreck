extends KinematicBody
class_name TrailerBase

export var speed: float = 8
export var velocityFall: float = 4
export var playerDistance: float = 20

var isSpinning: bool = false
var spinning_speed: int = 1

onready var stateMachine: StateMachine = $StateMachine

var ship: Player
var celestialBody
var markerType = 4

func _ready():
	add_to_group("minimap_targets", true)

func onAreaBodyEntered(body):
	if body is Player:
		body.TrailerAreaEntered(self)
	
func onAreaBodyExited(body):
	if body is Player:
		body.TrailerAreaExited(self)
	
func AttachToShip(ship: Player):
	if stateMachine.currentStateType == "stationary":
		self.ship = ship
		stateMachine.SetState("empty", false, [ship, false])


func AttachCelestialBody(body):
	if stateMachine.currentStateType == "empty":
		self.celestialBody = body
		stateMachine.SetState("towing", false, [ship, false, body])

func IsTowingCelestialBody():
	return stateMachine.currentStateType == "towing"

func PerformAction():
	pass


func slow_spin():
	isSpinning = true
	spinning_speed = 1


func fast_spin():
	isSpinning = true
	spinning_speed = 3


func stop_spin():
	isSpinning = false
	spinning_speed = 0


func _process(delta):
	$TrailerMesh.rotate_y(delta * int(isSpinning) * spinning_speed)
