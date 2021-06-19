extends MarginContainer
class_name Minimap

export(NodePath) var shipPath
export var zoom: float = 0.5

onready var container: MarginContainer = $MarginContainer
onready var grid: TextureRect = $MarginContainer/Grid
onready var player: Sprite = $MarginContainer/Player
onready var planet: Sprite = $MarginContainer/Planet
onready var sun: Sprite = $MarginContainer/Sun
onready var warpgate: Sprite = $MarginContainer/Warpgate
onready var trailer: Sprite = $MarginContainer/Trailer
onready var hydrogenCloud: Sprite = $MarginContainer/HydrogenCloud
onready var rocksCloud: Sprite = $MarginContainer/RocksCloud
onready var iceCloud: Sprite = $MarginContainer/IceCloud
onready var ship: Player = get_node(shipPath)

var scale: Vector2
var markerTypeDict: Dictionary
var visibleMarkers: Dictionary

enum MarkerTypes { Player = 0, Planet = 1, Sun = 2, Warpgate = 3, Trailer = 4, HydrogenCloud = 5, RocksCloud = 6, IceCloud = 7 }

func _ready():
	player.position = grid.rect_size / 2
	scale = grid.rect_size / (get_viewport_rect().size * zoom)
	markerTypeDict = {
		MarkerTypes.Planet: planet,
		MarkerTypes.Sun: sun,
		MarkerTypes.Warpgate: warpgate,
		MarkerTypes.Trailer: trailer,
		MarkerTypes.HydrogenCloud: hydrogenCloud,
		MarkerTypes.RocksCloud: rocksCloud,
		MarkerTypes.IceCloud: iceCloud
	}
	
	var nodes = get_tree().get_nodes_in_group("minimap_targets")
	for node in nodes:
		AddMarker(node)
		
func _process(delta: float):
	player.rotation = -ship.rotation.y
	
	for node in visibleMarkers:
		var position = (Vector2(node.translation.x, node.translation.z) - Vector2(ship.translation.x, ship.translation.z)) * scale + grid.rect_size / 2
		position.x = clamp(position.x, 0, grid.rect_size.x)
		position.y = clamp(position.y, 0, grid.rect_size.y)
		visibleMarkers[node].position = position

func AddMarker(node):
	var type = node.markerType
	var sprite: Sprite = markerTypeDict[type].duplicate()
	container.add_child(sprite)
	sprite.show()
	visibleMarkers[node] = sprite
	
func RemoveMarker(node):
	var sprite: Sprite = visibleMarkers[node]
	visibleMarkers.erase(node)
	sprite.queue_free()
	
