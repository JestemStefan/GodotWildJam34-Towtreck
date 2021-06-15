extends State

const VectorUtils = preload("res://Utils/VectorUtils.gd")
const MovingResource = preload("res://Player/MovingResource.tscn")

var towingTarget
var succTarget: GameResource
var resources: Array
var isSucc = false

onready var path: Path = $Path
onready var timer: Timer = $Timer

func OnStateLoad(parameters: Array):
	towingTarget = parameters[0]
	resources = get_tree().get_nodes_in_group("resources")
	
func OnStateUnload():
	path.curve.clear_points()
	timer.stop()
	
func Process(delta: float):
	if resources.size() == 0:
		resources = get_tree().get_nodes_in_group("resources")
	
	if Input.is_action_just_pressed("select"):
		
		# Check if towing target CAN be placed in orbit
		if towingTarget is Planet:
			if towingTarget.unhook_to_orbit() == OK:
				stateMachine.SetState("empty")
		
		elif towingTarget is Sun:
			(towingTarget as Sun).unhook_from_ship()
			stateMachine.SetState("empty")
			
	if Input.is_action_pressed("succ"):
		if target.nearbyResourceCloud != null and !isSucc:
			TurnOnSucc(target.nearbyResourceCloud)
		elif target.nearbyResourceCloud == null and isSucc:
			TurnOffSucc()
	
	if Input.is_action_just_released("succ"):
		TurnOffSucc()

func PhysicsProcess(delta: float):
	if isSucc:
		path.rotation_degrees = target.rotation_degrees
		path.curve.set_point_position(0, succTarget.global_transform.origin - target.global_transform.origin)
		path.curve.set_point_position(2, towingTarget.global_transform.origin - target.global_transform.origin)
	
func Draw():
	pass
	
func Input(event: InputEvent):
	pass
	
func TurnOnSucc(nearestSucc: GameResource):
	path.curve.add_point(nearestSucc.global_transform.origin - target.global_transform.origin)
	path.curve.add_point(target.global_transform.origin - target.translation)
	path.curve.add_point(towingTarget.global_transform.origin - target.global_transform.origin)
	
	succTarget = nearestSucc
	isSucc = true
	timer.start()

func TurnOffSucc():
	timer.stop()
	isSucc = false
	succTarget = null
	path.curve.clear_points()
	for child in path.get_children():
		path.remove_child(child)

func SpawnMovingResource():
	if towingTarget is Planet:
		(towingTarget as Planet).grow_planet()
		
	if !isSucc:
		pass
	
	var res: MovingResource = MovingResource.instance()
	res.color = succTarget.color
	path.add_child(res)
