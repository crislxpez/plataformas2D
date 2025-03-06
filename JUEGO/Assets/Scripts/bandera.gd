extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var current_scene = get_tree().current_scene.scene_file_path  # Obtiene la ruta de la escena actual
		
		if current_scene == "res://Scenes/level.tscn":
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/level2.tscn")
		elif current_scene == "res://Scenes/level2.tscn":
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/finPartida.tscn")

func _deferred_change_scene():
	get_tree().change_scene_to_file("res://Scenes/level2.tscn")
