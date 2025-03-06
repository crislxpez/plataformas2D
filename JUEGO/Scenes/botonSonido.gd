extends TextureButton

@export var sound_on_texture: Texture2D
@export var sound_off_texture: Texture2D

var is_muted = false

func _ready():
	texture_normal = sound_on_texture 

func _on_pressed():
	is_muted = !is_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), is_muted)
	texture_normal = sound_off_texture if is_muted else sound_on_texture
