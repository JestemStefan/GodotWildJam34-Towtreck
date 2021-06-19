extends Spatial

func _process(_delta):
	if Input.is_action_just_pressed("select"):
		get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
		# Wait until the frame has finished before getting the texture.
		yield(VisualServer, "frame_post_draw")

		# Retrieve the captured image.
		var img = get_viewport().get_texture().get_data()

		# Flip it on the y-axis (because it's flipped).
		img.flip_y()
		img.save_png("res://logo_small.png")
