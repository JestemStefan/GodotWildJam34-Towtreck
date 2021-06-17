extends "res://Scenes/Trailer/States/FollowingState.gd"

var celestialBody: CelestialBody

func OnStateLoad(parameters: Array):
	.OnStateLoad(parameters)
	celestialBody = parameters[2]
	celestialBody.hook_to_trailer(target)
	
func OnStateUnload():
	if celestialBody is Planet:
		celestialBody.unhook_to_orbit()
	else:
		celestialBody.unhook_from_trailer()
		
func Process(delta: float):
	if Input.is_action_just_pressed("select"):
		if !firstInputIgnored:
			firstInputIgnored = true
		else:
			stateMachine.SetState("empty", false, [ship, true])
