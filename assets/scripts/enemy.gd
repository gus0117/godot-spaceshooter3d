extends Node3D

const SPEED = 3.0

@onready var gui : CanvasLayer = get_parent().get_node("GUI")
@onready var explosion : bool = false
@onready var gameover : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match explosion:
		false: global_position.z += SPEED * delta

func explosion_ctrl(explosion_scale : Vector3) -> void:
	explosion = true
	$Area3D.queue_free()
	$Explosion.scale = explosion_scale
	$Explosion.play("Exposion")
	#$Explosion/Audio.play()


func _on_area_3d_area_entered(area):
	if area.is_in_group("Shot"):
		explosion_ctrl(Vector3(1,1,1))
		GLOBAL.score += 10


func _on_area_3d_body_entered(body):
	if body is Player:
		gameover = true
		explosion_ctrl(Vector3(1.4, 1.4, 1.4))
		body.queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


func _on_explosion_animation_finished():
	match(gameover):
		false:
			queue_free()
		true:
			gui.get_node("Control/Fade/AnimationPlayer").play("fadeout")
