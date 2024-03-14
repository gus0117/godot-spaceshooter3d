extends Node3D

var SPEED : float = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.z += SPEED * delta


func _on_visible_on_screen_notifier_3d_screen_exited():
	global_position.z -= 80 # valor para colocar al principio el chunk, revisar
