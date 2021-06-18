extends TrailerBase

onready var planetPack = preload("res://Scenes/CelestialBodies/Planet_v1.tscn")

func PerformAction():
	if stateMachine.currentStateType == "towing":
		if celestialBody is Planet:
			celestialBody.grow_planet()
	
	elif stateMachine.currentStateType == "empty":
		var planet = planetPack.instance()
		planet.visible = false
		ship.get_parent().add_child(planet)
		AttachCelestialBody(planet)
		planet.visible = true
		stateMachine.currentState.firstInputIgnored = true
