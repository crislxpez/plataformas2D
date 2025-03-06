extends Camera2D

@export_category("⚙️ Config")

@export_group("Required References")
@export var player : CharacterBody2D

# ¿Por qué no se usa el parámetro delta? Porque su posición es igual a la posición del player, que se mueve haciendo uso del tiempo delta, implícito en el método move_and_slide.
func _process(_delta):
	global_position = player.global_position
