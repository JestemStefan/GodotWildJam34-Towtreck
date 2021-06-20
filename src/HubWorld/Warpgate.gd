extends Spatial
class_name Warpgate

export var gate_rotation_speed: float = 1

var isReadyToWarp: bool = false
var markerType = 3

enum Destinations{HUB, LVL_1, LVL_2, LVL_3, LVL_4, LVL_5}
export (Destinations) var WarpTo = Destinations.LVL_1

var isEnabled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("minimap_targets", true)
	
	if get_parent().name == "HubWorld":
		isEnabled = true
	
	else:
		LevelManager.warp_to_hub = self
	
	var label = $Viewport/Label
#	label.rect_position = get_viewport().get_camera().unproject_position(global_transform.origin)
	match WarpTo:
		Destinations.HUB:
			label.text = "Warp to mission hub" + (" closed" if !isEnabled else "")
		Destinations.LVL_1:
			label.text = "Warp to mission 1"
		Destinations.LVL_2:
			label.text = "Warp to mission 2"
		Destinations.LVL_3:
			label.text = "Warp to mission 3"
		Destinations.LVL_4:
			label.text = "Warp to mission 4"
		Destinations.LVL_5:
			label.text = "Warp to mission 5"
			

func _process(delta):
	
	if isEnabled:
		if isReadyToWarp:
			$Warpgate_Main.rotate_z(gate_rotation_speed * delta * 2)
			$Warpgate_second.rotate_z(gate_rotation_speed * -delta * 3)
			$Warpgate_third.rotate_z(gate_rotation_speed * delta * 4)
			
			if Input.is_action_just_pressed("select"):
				warp_to_level(WarpTo)
				
	if WarpTo == Destinations.HUB:
		$Viewport/Label.text = "Warp to mission hub" + (" closed" if !isEnabled else "")

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
			AudioManager.play_single_music_track(0)
			AudioManager.stop_single_music_track(1)
			AudioManager.stop_single_music_track(2)
			AudioManager.stop_single_music_track(3)
			
			LevelManager.SetupLevel(Vector2(120, -120), Vector2(-120, 120), [], [], [], [])
			if LevelManager.completedLevels == 0:
				LevelManager.completedLevels = 1
			
		Destinations.LVL_2:
			AudioManager.play_single_music_track(0)
			AudioManager.stop_single_music_track(1)
			AudioManager.stop_single_music_track(2)
			AudioManager.stop_single_music_track(3)
			
			var planet1 = {
				orbit = 120,
				rocksPercent = 100,
				hydrogenPercent = 0,
				icePercent = 0
			}
			LevelManager.SetupLevel(Vector2(120, -120), Vector2(120, -120), [planet1], [], [Vector2(150, 0), Vector2(200, 100), Vector2(-200, -150)], [])
			if LevelManager.completedLevels == 1:
				LevelManager.completedLevels = 2
			
		Destinations.LVL_3:
			AudioManager.play_single_music_track(0)
			AudioManager.stop_single_music_track(1)
			AudioManager.stop_single_music_track(2)
			AudioManager.stop_single_music_track(3)
			
			var planet1 = {
				orbit = 90,
				rocksPercent = 20,
				hydrogenPercent = 30,
				icePercent = 50
			}
			var planet2 = {
				orbit = 150,
				rocksPercent = 50,
				hydrogenPercent = 10,
				icePercent = 40
			}
			LevelManager.SetupLevel(Vector2(-120, 200), Vector2(100, -200), [planet1, planet2], [Vector2(300, 0), Vector2(0, 300)], [Vector2(150, 0), Vector2(200, 100)], [Vector2(-200, -150), Vector2(-200, 200)])
			if LevelManager.completedLevels == 2:
				LevelManager.completedLevels = 3
			
		Destinations.LVL_4:
			AudioManager.play_single_music_track(0)
			AudioManager.stop_single_music_track(1)
			AudioManager.stop_single_music_track(2)
			AudioManager.stop_single_music_track(3)
			
			var planet1 = {
				orbit = 90,
				rocksPercent = 20,
				hydrogenPercent = 30,
				icePercent = 50
			}
			var planet2 = {
				orbit = 120,
				rocksPercent = 50,
				hydrogenPercent = 10,
				icePercent = 40
			}
			var planet3 = {
				orbit = 180,
				rocksPercent = 40,
				hydrogenPercent = 30,
				icePercent = 30
			}
			LevelManager.SetupLevel(Vector2(200, -120), Vector2(100, 200), [planet1, planet2, planet3], [Vector2(200, 0), Vector2(0, 300)], [Vector2(-150, 150), Vector2(200, -100)], [Vector2(-200, -150), Vector2(-150, 150)])
			if LevelManager.completedLevels == 3:
				LevelManager.completedLevels = 4
			
		Destinations.LVL_5:
			AudioManager.play_single_music_track(0)
			AudioManager.stop_single_music_track(1)
			AudioManager.stop_single_music_track(2)
			AudioManager.stop_single_music_track(3)
			
			var planet1 = {
				orbit = 50,
				rocksPercent = 65,
				hydrogenPercent = 25,
				icePercent = 10
			}
			var planet2 = {
				orbit = 90,
				rocksPercent = 45,
				hydrogenPercent = 40,
				icePercent = 15
			}
			var planet3 = {
				orbit = 150,
				rocksPercent = 33,
				hydrogenPercent = 0,
				icePercent = 0
			}
			var planet4 = {
				orbit = 200,
				rocksPercent = 100,
				hydrogenPercent = 0,
				icePercent = 0
			}
			var planet5 = {
				orbit = 300,
				rocksPercent = 100,
				hydrogenPercent = 0,
				icePercent = 0
			}
			LevelManager.SetupLevel(Vector2(300, -420), Vector2(-300, -300), [planet1, planet2, planet3, planet4, planet5], [Vector2(-200, -300)], [Vector2(200, 100)], [Vector2(0, -150)])
			if LevelManager.completedLevels == 4:
				LevelManager.completedLevels = 5
			
			
