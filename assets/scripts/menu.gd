extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%Start.grab_focus()


func _on_start_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	$Fade/AnimationPlayer.play("fadeout")


func _on_animation_player_animation_finished(anim_name):
	match(anim_name):
		"fadeout": get_tree().quit()
