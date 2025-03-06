extends CharacterBody2D
class_name Enemy

@export_category("⚙️ Config")

@export_group("Options")
@export var health : int = 1
@export var score : int = 100

@export_group("Motion")
@export var speed : int = 16
@export var gravity : int = 16

var direction : int = 1 # Cómo el enemigo se mueve solo, vamos a definir su dirección con una variable.

func _process(_delta):
	if health > 0: # Nos aseguramos que solo se mueva, si su salud es mayor que 0.
		motion_ctrl()


func motion_ctrl() -> void:
	$Sprite.scale.x = direction
	
	# Si detecta un precipicio o toca una pared, cambia de dirección
	if not $Sprite/RayGround.is_colliding() or is_on_wall():
		direction *= -1
	
	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()


# Esta función la llama el player, pasándole como parámetro el daño recibido, de esa forma podemos hacer que reciba una cantidad de daño variable, si hipotéticamente implementásemos power-ups.
func damage_ctrl(damage : int) -> void:
	health -= damage
	
	if health <= 0:
		$Sprite.set_animation("Death")
		# Si call_deferred es llamada segura, set_deferred es establecer un parámetro de forma segura, que en este caso es necesario porque estamos desactivando la colisión.
		$Collision.set_deferred("disabled", true)
		# Si desactivamos la colisión, pero no seteamos la gravedad a 0, el personaje se hundiría mientras se reproduce la animación de muerte.
		gravity = 0
		GLOBAL.score += score # Y sumamos al score el puntaje.


func _on_sprite_animation_finished():
	if $Sprite.animation == "Death":
		queue_free()


func _on_area_hit_body_entered(body):
	if body is Player and health > 0:
		body.damage_ctrl()
