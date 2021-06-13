extends Spatial
class_name Planet

# Planet stats
var planet_weight: float = 1


func _ready():
	add_to_group("planets", true)
	update_size()


func _process(delta):
	$PlanetsSurface.rotate_y(0.1 * delta)
	$Clouds.rotate_y(0.2 * delta)


func grow_planet():
	planet_weight += 0.5 + (planet_weight * 0.01)
	update_size()


func shrink_planet():
	planet_weight -= 0.5 + (planet_weight * 0.01)
	update_size()


func update_size():
	if planet_weight > 1:
		self.scale = Vector3.ONE * (pow(0.75 * planet_weight, 0.3))
	
	else:
		planet_weight = 1
		self.scale = Vector3.ONE
