extends Control

func _ready():
	$Buttons/Start.grab_focus()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_exit_pressed():
	get_tree().quit()

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menuControles2.tscn")
