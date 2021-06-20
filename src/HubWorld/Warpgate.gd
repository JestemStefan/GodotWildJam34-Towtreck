extends Spatial
class_name Warpgate

export var gate_rotation_speed: float = 1

var isReadyToWarp: bool = false
var markerType = 3

enum Destinations{HUB, LVL_1}
export (Destinations) var WarpTo = Destinations.LVL_1

var isEnabled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("minimap_targets", true)
	
	if get_parent().name == "HubWorld":
		isEnabled = true
	
	else:
		LevelManager.warp_to_hub = self


func _process(delta):
	
	if isEnabled:
		if isReadyToWarp:
			$Warpgate_Main.rotate_z(gate_rotation_speed * delta * 2)
			$Warpgate_second.rotate_z(gate_rotation_speed * -delta * 3)
			$Warpgate_third.rotate_z(gate_rotation_speed * delta * 4)
			
			if Input.is_action_just_pressed("select"):
				warp_to_level(WarpTo)

func open_warpgate():
	isReadyToWarp = true
	$AnimationPlayer.play("Turn_On")


func close_warpgate():
	isReadyToWarp = false
	$AnimationPlayer.play("Turn_Off")


func enable():
	isEnabled = true


func disable():
	isEnabled = false


func _on_AnimationPlayer_animation_finished(anim_name):
	pass


func _on_Warpgate_body_entered(body):
	if body is Player and isEnabled:
		open_warpgate()


func _on_Warpgate_body_exited(body):
	if body is Player and isEnabled:
		close_warpgate()


func warp_to_level(level_idx: int):
	
	match level_idx:
		
		Destinations.HUB:
			AudioManager.play_single_music_track(0)
			AudioManager.play_single_music_track(1)
			AudioManager.play_single_music_track(2)
			AudioManager.stop_single_music_track(3)
			
			get_tree().change_scene("res://Scenes/HubWorld/HubWorld.tscn")
		
		Destinations.LVL_1:
			
			AudioManager.play_all_music_tracks()
			
			var planet1 = {
							orbit = 50,
							icePercent = 20,
							rocksPercent = 50,
							hydrogenPercent = 30
							}
			var planet2 = {
							orbit = 111,
							icePercent = 50,
							rocksPercent = 50,
							hydrogenPercent = 0
							}
			LevelManager.SetupLevel(Vector2(60, 60), [planet1, planet2], [Vector2(-60, -60)], [Vector2(60, -60)], [Vector2(-60, 60)])
