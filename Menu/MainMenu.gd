extends Control

func _ready():
	if OS.get_name() == "HTML5":
		$CenterContainer/VBoxContainer/QuitButton.hide()

func _onStartButtonPressed():
#	get_tree().change_scene("res://World/TestEnvironment.tscn")
#	var planet1 = {
#		orbit = 50,
#		icePercent = 20,
#		rocksPercent = 50,
#		hydrogenPercent = 30
#	}
#	var planet2 = {
#		orbit = 111,
#		icePercent = 50,
#		rocksPercent = 50,
#		hydrogenPercent = 0
#	}
#	LevelManager.SetupLevel(Vector2(60, 60), [planet1, planet2], [Vector2(-60, -60)], [Vector2(60, -60)], [Vector2(-60, 60)])
	get_tree().change_scene("res://Scenes/HubWorld/HubWorld.tscn")

func _onOptionButtonPressed():
	get_tree().change_scene("res://Menu/Options/Options.tscn")

func _onCreditsButtonPressed():
	get_tree().change_scene("res://Menu/Credits/Credits.tscn")

func _onQuitButtonPressed():
	get_tree().quit(0)
