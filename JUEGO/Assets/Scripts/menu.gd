extends Control

@onready var volume_slider = $Volumen 

func _ready():
	var default_volume_db = _percent_to_db(50)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), default_volume_db)
	var current_volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	var initial_slider_value = _db_to_percent(current_volume_db)
	volume_slider.value = initial_slider_value
	volume_slider.value_changed.connect(_on_volume_slider_changed)
	
	$Buttons/Start.grab_focus()


func _on_start_pressed():

	get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_exit_pressed():
	get_tree().quit()

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menuControles2.tscn")
	
func _on_volume_slider_changed(value: float):
	# Convertir el valor del slider (0-100) a decibelios
	var volume_db = _percent_to_db(value)
	# Ajustar el volumen del bus "Master"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

# Función para convertir porcentaje (0-100) a decibelios
func _percent_to_db(percent: float) -> float:
	return (percent / 100) * 30 - 30

# Función para convertir decibelios a porcentaje (0-100)
func _db_to_percent(db: float) -> float:
	return ((db + 30) / 30) * 100
