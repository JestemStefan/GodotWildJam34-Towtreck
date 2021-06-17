extends Spatial

class_name GameResource

export var color: Color
export var resourceType: String

enum ResourceType{HYDROGEN, ROCKS, ICE}
export(ResourceType) var CloudType = ResourceType.HYDROGEN

func _ready():
	add_to_group("resources")

func areaEntered(body):
	if body is Player:
		body.ResourceAreaEntered(self)
		
		# I added it to save some performance. I heard HTML is bad with lighting
		$OmniLight.show()
		
func areaExited(body):
	if body is Player:
		body.ResourceAreaExited(self)
		
		# I added it to save some performance. I heard HTML is bad with lighting
		$OmniLight.hide()
		

func mine_resource():
	pass
