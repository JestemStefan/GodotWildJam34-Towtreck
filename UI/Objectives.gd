extends MarginContainer

const objectivePart = preload("res://UI/ObjectivePart.tscn")

onready var mainContainer: VBoxContainer = $MarginContainer/MainContainer

var objectives: Dictionary = {}

func _ready():
	LevelManager.objectivesUI = self
	
func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		for obj in objectives.values():
			obj.isDone = true

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

func PercentageDone():
	if objectives.size() == 0:
		return 0
	
	var done = 0
	for obj in objectives.values():
		if obj.isDone:
			done += 1
			
	return round(done * 100 / objectives.size())
