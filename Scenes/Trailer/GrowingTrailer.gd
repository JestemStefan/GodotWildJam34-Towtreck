extends TrailerBase

export var minimapPath: NodePath

onready var planetPack = preload("res://Scenes/CelestialBodies/Planet_v1.tscn")
onready var minimap: Minimap = get_node(minimapPath)

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
		minimap.AddMarker(1, planet)
