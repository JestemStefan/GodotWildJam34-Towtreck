extends KinematicBody
class_name TrailerBase

export var speed: float = 8
export var velocityFall: float = 4
export var playerDistance: float = 20

onready var stateMachine: StateMachine = $StateMachine

var ship: Player
var celestialBody

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