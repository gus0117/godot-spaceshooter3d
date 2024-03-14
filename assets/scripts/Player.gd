extends CharacterBody3D
class_name Player

var shot : PackedScene = preload("res://scenes/shot.tscn")
var can_shot : bool = false


const SPEED = 2.5

func _process(delta):
	motion_ctrl()
	anim_ctrl()

func _input(event):
	if can_shot and event.is_action_pressed("ui_shot"):
		shoot_ctrl()

func tween_ctrl(node, property: String, final_val, duration: float) -> void:
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(node, property, final_val, duration)
	pass

func shoot_ctrl() -> void:
	#$Settings/AudioShoot.play()
	var shot_instance : Area3D = shot.instantiate()
	get_tree().call_group("Level", "add_child", shot_instance)
	shot_instance.set_global_position($Settings/ShootSpawner.global_position())
	pass

func motion_ctrl() -> void:
	velocity.x = GLOBAL.get_axis().x * SPEED
	velocity.z = GLOBAL.get_axis().y * SPEED
	move_and_slide()

func anim_ctrl() -> void:
	if GLOBAL.get_axis().x > 0:
		tween_ctrl($Spaceship, "rotation", Vector3($Spaceship.rotation.x, $Spaceship.rotation.y, 0.6), 0.6)
	elif GLOBAL.get_axis().x < 0:
		tween_ctrl($Spaceship, "rotation", Vector3($Spaceship.rotation.x, $Spaceship.rotation.y, -0.6), 0.6)
	else:
		tween_ctrl($Spaceship, "rotation", Vector3.ZERO, 0.5)

func _on_crossair_area_entered(area):
	if area.is_in_group("Enemy"):
		can_shot = true
		tween_ctrl($Settings/Crossair/Sprite3D, "scale", Vector3(0.6, 0.6, 0.6), 0.2)
		tween_ctrl($Settings/Crossair/Sprite3D, "modulate", Color(0.55, 0.76, 0.29, 1.0), 0.1)
		#$Settings/Crossair/Sound.play()


func _on_crossair_area_exited(area):
	if area.is_in_group("Enemy"):
		can_shot = false
		tween_ctrl($Settings/Crossair/Sprite3D, "scale", Vector3(0.3, 0.3, 0.3), 0.2)
		tween_ctrl($Settings/Crossair/Sprite3D, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.1)
