extends Control

func _ready():
	if OS.get_name() == "HTML5":
		$CenterContainer/VBoxContainer/QuitButton.hide()

func _onStartButtonPressed():
	get_tree().change_scene("res://World/TestEnvironment.tscn")

func _onOptionButtonPressed():
	get_tree().change_scene("res://Menu/Options/Options.tscn")

func _onCreditsButtonPressed():
	get_tree().change_scene("res://Menu/Credits/Credits.tscn")

func _onQuitButtonPressed():
	get_tree().quit(0)
