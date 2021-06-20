extends MarginContainer

const objectivePart = preload("res://UI/ObjectivePart.tscn")

onready var mainContainer: VBoxContainer = $MarginContainer/MainContainer

var objectives: Dictionary = {}

func _ready():
	LevelManager.objectivesUI = self

func AddObjective(name: String, label: String):
	var newObj = objectivePart.instance()
	mainContainer.add_child(newObj)
	objectives[name] = newObj
	newObj.labelText = label

func SetObjective(name: String, isDone: bool):
	objectives[name].isDone = isDone

func AllDone():
	if objectives.size() > 0:
		for obj in objectives.values():
			if !obj.isDone:
				return false
		return true
	return false
