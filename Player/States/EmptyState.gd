extends State

const VectorUtils = preload("res://Utils/VectorUtils.gd")

var planets: Array

func OnStateLoad(parameters: Array):
	planets = get_tree().get_nodes_in_group("celestial_bodies")

func OnStateUnload():
	pass

func Process(delta: float):
	if planets.size() == 0:
		planets = get_tree().get_nodes_in_group("celestial_bodies")
	
	if Input.is_action_just_pressed("select"):
		if target.nearbyCelestialBody != null:
			target.nearbyCelestialBody.hook_to_ship(target)
			stateMachine.SetState("towing", false, [target.nearbyCelestialBody])

func PhysicsProcess(delta: float):
	pass

func Draw():
	pass

func Input(event: InputEvent):
	pass

