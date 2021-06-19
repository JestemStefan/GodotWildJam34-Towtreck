extends CenterContainer

onready var label: Label = $HBoxContainer/Label
onready var doneMark: TextureRect = $HBoxContainer/DoneMark
onready var pendingMark: TextureRect = $HBoxContainer/PendingMark

onready var labelText: String = "" setget SetLabel
onready var isDone: bool = false setget SetIsDone

func SetLabel(value: String):
	labelText = value
	label.text = value

func SetIsDone(value: bool):
	isDone = value
	MarkObjective()

func _ready():
	MarkObjective()
	
func MarkObjective():
	if isDone:
		pendingMark.hide()
		doneMark.show()
	else:
		doneMark.hide()
		pendingMark.show()
