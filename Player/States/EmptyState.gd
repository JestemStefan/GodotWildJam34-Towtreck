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
		var nearest = planets[0]
		var nearestDistance = VectorUtils.GetDistance(target, nearest)
		
		for planet in planets:
			var distance = VectorUtils.GetDistance(target, planet)
			if distance < nearestDistance:
				nearestDistance = distance
				nearest = planet
		
		if nearest is Planet:
			if nearestDistance < 25:
				(nearest as Planet).hook_to_ship()
				stateMachine.SetState("towing", false, [nearest])
		
		elif nearest is Sun:
			if nearestDistance < 50:
				(nearest as Sun).hook_to_ship()
				stateMachine.SetState("towing", false, [nearest])

func PhysicsProcess(delta: float):
	pass

func Draw():
	pass

func Input(event: InputEvent):
	pass

