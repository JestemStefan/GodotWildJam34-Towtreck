extends State

var planets: Array

func OnStateLoad(parameters: Array):
	planets = get_tree().get_nodes_in_group("planets")

func OnStateUnload():
	pass

func Process(delta: float):
	planets = get_tree().get_nodes_in_group("planets")
	if Input.is_action_just_pressed("select"):
		var nearest = planets[0]
		var nearestDistance = GetDistance(nearest)
		
		for planet in planets:
			var distance = GetDistance(planet)
			if distance < nearestDistance:
				nearestDistance = distance
				nearest = planet
		
		if nearestDistance < 10:
			stateMachine.SetState("towing", false, [nearest])

func PhysicsProcess(delta: float):
	pass

func Draw():
	pass

func Input(event: InputEvent):
	pass

func GetDistance(toWhere: Spatial) -> float:
	return target.global_transform.origin.distance_to(toWhere.global_transform.origin)
