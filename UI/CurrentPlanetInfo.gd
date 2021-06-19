extends MarginContainer

onready var orbitLabel: Label = $MarginContainer/VBoxContainer/CenterContainer5/HBoxContainer/OrbitLabel
onready var weightLabel: Label = $MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/WeightLabel
onready var rocksLabel: Label = $MarginContainer/VBoxContainer/CenterContainer2/HBoxContainer/RocksLabel
onready var hydrogenLabel: Label = $MarginContainer/VBoxContainer/CenterContainer3/HBoxContainer/HydrogenLabel
onready var iceLabel: Label = $MarginContainer/VBoxContainer/CenterContainer4/HBoxContainer/IceLabel

var currentPlanet: Planet

func _process(delta):
	var player = LevelManager.current_level.player as Player
	if player.stateMachine.currentStateType == "towing":
		var trailer = player.stateMachine.currentState.towingTarget as TrailerBase
		var body = trailer.celestialBody as CelestialBody
		if is_instance_valid(body) and body is Planet and !is_instance_valid(currentPlanet):
			currentPlanet = body
			show()
		elif (!is_instance_valid(body) or !(body is Planet)) and is_instance_valid(currentPlanet):
			currentPlanet = null
			hide()
	
	if is_instance_valid(currentPlanet):
		orbitLabel.text = String(round(currentPlanet.global_transform.origin.distance_to(LevelManager.current_sun.global_transform.origin)))
		weightLabel.text = String(currentPlanet.materialWeight)
		rocksLabel.text = String(currentPlanet.rocksPercent) + "%"
		hydrogenLabel.text = String(currentPlanet.hydrogenPercent) + "%"
		iceLabel.text = String(currentPlanet.icePercent) + "%"
