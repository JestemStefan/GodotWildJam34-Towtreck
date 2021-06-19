extends TrailerBase

onready var planetPack = preload("res://Scenes/CelestialBodies/Planet_v1.tscn")

func PerformAction(resourceCloud: GameResource):
	if stateMachine.currentStateType == "towing":
		if celestialBody is Planet:
			celestialBody.grow_planet(resourceCloud)
	
	elif stateMachine.currentStateType == "empty":
		var planet = planetPack.instance()
		planet.visible = false
		ship.get_parent().add_child(planet)
		AttachCelestialBody(planet)
		planet.visible = true
		stateMachine.currentState.firstInputIgnored = true

func PerformSecondaryAction(resourceCloud: GameResource):
	if stateMachine.currentStateType == "towing":
		if celestialBody is Planet:
			celestialBody.shrink_planet(resourceCloud)
			if celestialBody.materialWeight < 1:
				celestialBody.hide()
				ship.get_parent().remove_child(celestialBody)
				celestialBody.queue_free()
				stateMachine.SetState("empty", false, [ship, false])
