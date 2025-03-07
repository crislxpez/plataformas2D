extends CharacterBody2D
class_name Player

var axis : Vector2 = Vector2.ZERO
var death : bool = false

@export_category("⚙️ Config")
@export_group("Required References")
@export var gui : CanvasLayer

@export_group("Motion")
@export var speed : int = 128
@export var gravity : int = 16
@export var jump : int = 368

func _process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()


func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)


func get_axis() -> Vector2: 
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()


func motion_ctrl() -> void:
	'''MOVIMIENTO'''
	if not get_axis().x == 0:
		$Sprite.scale.x = get_axis().x
	
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	
	move_and_slide() # En el método move_and_slide va implicito el tiempo delta.
	
	'''ANIMACIONES'''
	match is_on_floor():
		true:
			if not get_axis().x == 0:
				$Sprite.set_animation("Run")
			else:
				$Sprite.set_animation("Idle")
		false: 
			if velocity.y < 0: #  Si velocity.y es menor que cero, significa que se encuentra subiendo.
				$Sprite.set_animation("Jump")
			else: # De lo contrario, está cayendo.
				$Sprite.set_animation("Fall")


func death_ctrl() -> void:
	velocity.x = 0 
	velocity.y += gravity 
	move_and_slide()


func jump_ctrl(power : float) -> void: # parámetro para indicarle la fuerza de salto.
	velocity.y = -jump * power
	$Audio/Jump.play()


func damage_ctrl() -> void:
	death = true
	$Sprite.set_animation("Death")


func _on_hit_point_body_entered(body):
	# Esto solo va a funcionar si es un enemigo y el personaje se encuentra cayendo, no subiendo.
	if body is Enemy and velocity.y >= 0:
		$Audio/Hit.play()
		body.damage_ctrl(1)
		jump_ctrl(0.75)


func _on_sprite_animation_finished():
	if $Sprite.animation == "Death":
		gui.game_over()
