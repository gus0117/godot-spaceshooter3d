extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%Score.text = "SCORE: " + str(GLOBAL.score)


func _on_animation_player_animation_finished(anim_name):
	match(anim_name):
		"fadeout":
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
