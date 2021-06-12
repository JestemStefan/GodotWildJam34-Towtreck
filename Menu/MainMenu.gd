extends Control

func _onStartButtonPressed():
	get_tree().change_scene("res://temp_root.tscn")

func _onOptionButtonPressed():
	get_tree().change_scene("res://Menu/Options/options_menu_example.tscn")
