extends CanvasLayer


func _process(_delta):
	$Container/Label.text = "SCORE: " + str(GLOBAL.score)
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($GameOver, "modulate", Color(1, 1, 1, 0.8), 1.0)


func _on_restart_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/level.tscn")


func _on_exit_pressed():
	get_tree().quit()
	
func _deferred_change_scene():
	get_tree().change_scene_to_file("res://Scenes/level2.tscn")


func _on_ready() -> void:
	$GameOver/Container/Buttons/Restart.grab_focus()
