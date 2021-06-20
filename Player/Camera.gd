extends Camera

export var playerPath: NodePath

onready var player = get_node(playerPath)


func _ready():
	add_hints()

func _physics_process(delta):
	translation.x = player.translation.x
	translation.z = player.translation.z + 60



func add_hints():
	var hint_succ: Label = $HBoxContainer/Label
	var hint_select: Label = $HBoxContainer/Label2
	var hint_special: Label = $HBoxContainer/Label3
	
	
	for action in InputMap.get_action_list("succ"):
		if action is InputEventKey:
			hint_succ.text = "Press " + OS.get_scancode_string(action.scancode) + " to collect resources"
			break
		
	for action in InputMap.get_action_list("select"):
		if action is InputEventKey:
			hint_select.text = "Press " + OS.get_scancode_string(action.scancode) + " to tow/eject/use objects"
			break
		
	for action in InputMap.get_action_list("special"):
		if action is InputEventKey:
			hint_special.text = "Press " + OS.get_scancode_string(action.scancode) + " to discard resources"
			break
	
	
	
	
