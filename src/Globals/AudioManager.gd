extends Node

var _sfx_playing: Array = []
var _music_playing: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_sfx(sfx_sound: AudioStreamSample, should_loop: bool = false):
	
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
	
	(sfx_player.stream as AudioStreamSample).set_loop_mode(int(should_loop)) 	# enable or diable looping
	
	if should_loop:
		(sfx_player.stream as AudioStreamSample).loop_begin = 0
		(sfx_player.stream as AudioStreamSample).loop_end = sfx_sound.get_length() * sfx_sound.mix_rate
	
	# play sound
	sfx_player.play()


func stop_sfx(sfx_to_stop: AudioStreamSample):
	
	for sfx_player in _sfx_playing:
		if is_instance_valid(sfx_player):
			if sfx_player.stream == sfx_to_stop:
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
