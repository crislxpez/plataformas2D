extends CanvasLayer

func _ready() -> void:
	$ColorRect/Buttons/Reanudar.grab_focus()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
		$ColorRect.visible = not $ColorRect.visible
		$ColorRect/Buttons/Reanudar.grab_focus()

func _on_reanudar_pressed() -> void:
	get_tree().paused = not get_tree().paused
	$ColorRect.visible = not $ColorRect.visible

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	get_tree().quit()
