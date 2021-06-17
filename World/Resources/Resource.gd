extends Spatial

class_name GameResource

export var color: Color
export var resourceType: String

enum ResourceType{HYDROGEN, ROCKS, ICE}
export(ResourceType) var CloudType = ResourceType.HYDROGEN

onready var _hydrogen_ps_cloud = preload("res://art/Particles/Hydrogen_Cloud_PS.tscn")
onready var _hydrogen_gathering_ps = preload("res://art/Particles/HydrogenGathering.tscn")

onready var _rock_ps_cloud = preload("res://art/Particles/Rock_Cloud_PS.tscn")
onready var _rock_gathering_ps = preload("res://art/Particles/Rock_Gathering.tscn")

onready var _ice_ps_cloud = preload("res://art/Particles/Ice_Cloud_PS.tscn")
onready var _ice_gathering_ps = preload("res://art/Particles/Ice_Gathering.tscn")

var gathering_ps

func _ready():
	add_to_group("resources")
	
	var cloud_particle_system: CPUParticles
	var cloud_light_color: Color
	
	match CloudType:
		ResourceType.HYDROGEN:
			cloud_particle_system = _hydrogen_ps_cloud.instance()
			gathering_ps = _hydrogen_gathering_ps
			cloud_light_color = Color.red
		
		ResourceType.ROCKS:
			cloud_particle_system = _rock_ps_cloud.instance()
			gathering_ps = _rock_gathering_ps
			cloud_light_color = Color.orange
		
		ResourceType.ICE:
			cloud_particle_system = _ice_ps_cloud.instance()
			gathering_ps = _ice_gathering_ps
			cloud_light_color = Color.blue
	
	add_child(cloud_particle_system)
	$OmniLight.light_color = cloud_light_color
		

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
