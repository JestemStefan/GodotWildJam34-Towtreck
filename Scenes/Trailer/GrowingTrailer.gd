extends TrailerBase

func PerformAction():
	if stateMachine.currentStateType == "towing":
		if celestialBody is Planet:
			celestialBody.grow_planet()
