extends Node

var _sfx_playing: Array = []
var music_sync_animPlayer: AnimationPlayer

var music_all_tracks: Array
var music_track_1: AudioStreamPlayer
var music_track_2: AudioStreamPlayer
var music_track_3: AudioStreamPlayer
var music_track_4: AudioStreamPlayer

onready var _musicAudioAnimPlayer_instance: PackedScene = preload("res://Audio/MusicAudioPlayer.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_music_players()
	music_sync_animPlayer.play("SynchronizedMusic")
	
	play_single_music_track(0)


func spawn_music_players():
	music_sync_animPlayer = _musicAudioAnimPlayer_instance.instance()
	add_child(music_sync_animPlayer)
	
	music_all_tracks = music_sync_animPlayer.get_children()
	music_track_1 = music_all_tracks[0]
	music_track_2 = music_all_tracks[1]
	music_track_3 = music_all_tracks[2]
	music_track_4 = music_all_tracks[3]


func play_single_music_track(track):
	
	# create empty ASP
	var track_to_play: AudioStreamPlayer
	
	# param can be index of a track or track itself so check
	if track is int:
		track_to_play = music_all_tracks[track]
	
	elif track is AudioStreamPlayer:
		track_to_play = track
	
	# fade in/out using tween
	var _tween = Tween.new()
	add_child(_tween)
	
	_tween.interpolate_property(track_to_play, 
								"volume_db",
								track_to_play.volume_db,
								0,
								2,
								Tween.TRANS_LINEAR,
								Tween.EASE_IN)
	_tween.start()
	yield(_tween, "tween_completed")
	_tween.call_deferred("free")


func play_all_music_tracks():
	
	var _tween = Tween.new()
	add_child(_tween)
	
	for track_i in music_all_tracks:
		_tween.interpolate_property(track_i, 
									"volume_db",
									(track_i as AudioStreamPlayer).volume_db,
									0,
									2,
									Tween.TRANS_LINEAR,
									Tween.EASE_IN)	
	_tween.start()
	yield(_tween, "tween_completed")
	_tween.call_deferred("free")


func stop_single_music_track(track):
	
	var track_to_play: AudioStreamPlayer
	
	if track is int:
		track_to_play = music_all_tracks[track]
	
	elif track is AudioStreamPlayer:
		track_to_play = track
	
	
	var _tween = Tween.new()
	add_child(_tween)
	
	_tween.interpolate_property(track_to_play, 
								"volume_db",
								track_to_play.volume_db,
								-80.0,
								2,
								Tween.TRANS_LINEAR,
								Tween.EASE_IN)
	_tween.start()
	yield(_tween, "tween_completed")
	_tween.call_deferred("free")


func stop_all_music_tracks():
	var _tween = Tween.new()
	add_child(_tween)
	
	for track_i in music_all_tracks:
		_tween.interpolate_property(track_i, 
									"volume_db",
									(track_i as AudioStreamPlayer).volume_db,
									-80,
									2,
									Tween.TRANS_LINEAR,
									Tween.EASE_IN)	
	_tween.start()
	yield(_tween, "tween_completed")
	_tween.call_deferred("free")



func play_sfx(sfx_sound: AudioStreamSample, should_loop: bool = false, volume: float = 0):
	
	# create new audio player and spawn it
	var sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	
	# add to list of sfx
	_sfx_playing.append(sfx_player)
	
	# connect signal that will be emitted when sound finished playing
	sfx_player.connect("finished", self, "_on_sfx_ended", [sfx_player])
	
	# assign selected sound to player and apply options
	sfx_player.set_bus("SFX") 							# assign audio bus
	sfx_player.stream = sfx_sound						# assign sound that will be played
	sfx_player.volume_db = volume
	
	(sfx_player.stream as AudioStreamSample).set_loop_mode(int(should_loop)) 	# enable or diable looping
	
	# set up loop range
	if should_loop:
		(sfx_player.stream as AudioStreamSample).loop_begin = 0
		(sfx_player.stream as AudioStreamSample).loop_end = sfx_sound.get_length() * sfx_sound.mix_rate
	
	# play sound
	sfx_player.play()


func stop_sfx(sfx_to_stop: AudioStreamSample):
	
	# check each all saved audio players and look for the one playing sfx that should be stopped
	for sfx_player in _sfx_playing:
		
		# if player still exists
		if is_instance_valid(sfx_player):
			
			# if found the one that plays sfx from param
			if sfx_player.stream == sfx_to_stop:
				
				# remove player from the list and delete it
				_sfx_playing.erase(sfx_player)
				sfx_player.call_deferred("free")
				return OK


func _on_sfx_ended(audio_player: AudioStreamPlayer):
	
	# if sfx should loop then play again
	if (audio_player.stream as AudioStreamSample).get_loop_mode():
		audio_player.play(0.0)
	
	# if not then delete audioplayer
	else:
		_sfx_playing.erase(audio_player)
		audio_player.call_deferred("free")
