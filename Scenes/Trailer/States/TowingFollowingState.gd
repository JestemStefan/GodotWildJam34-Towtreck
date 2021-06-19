extends "res://Scenes/Trailer/States/FollowingState.gd"

var celestialBody: CelestialBody

func OnStateLoad(parameters: Array):
	.OnStateLoad(parameters)
	celestialBody = parameters[2]
	celestialBody.hook_to_trailer(target)
	
func OnStateUnload():
	pass
		
func Process(delta: float):
	if Input.is_action_just_pressed("select"):
		if !firstInputIgnored:
			firstInputIgnored = true
		else:
			var ret
			if celestialBody is Planet:
				ret = celestialBody.unhook_to_orbit()
			else:
				ret = celestialBody.unhook_from_trailer()
				
			if ret == OK:
				stateMachine.SetState("empty", false, [ship, true])
