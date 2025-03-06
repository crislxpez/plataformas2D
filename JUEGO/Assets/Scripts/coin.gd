extends Area2D

func _on_body_entered(body):
	if body is Player:
		$Sprite.set_animation("Off")
		$Sound.play()
		GLOBAL.score += 100


func _on_sound_finished():
	queue_free()
