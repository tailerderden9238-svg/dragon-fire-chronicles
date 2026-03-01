extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var health = 100
var alive = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var speed = 100
var player = null 

func _physics_process(delta: float) -> void:
	# Гравитация работает всегда, даже если враг умирает (пока не удален)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Проверяем, жив ли враг
	if alive:
		if chase and player != null:
			# Движение к игроку
			var direction = (player.global_position - self.global_position).normalized()
			velocity.x = direction.x * speed
			
			anim.play("Run")
			anim.flip_h = direction.x < 0
		else:
			# Остановка и покой
			velocity.x = move_toward(velocity.x, 0, speed)
			anim.play("Idle")
	else:
		# Если мертв, плавно останавливаем горизонтальное движение
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		chase = true

func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false
		player = null

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Player" and alive:
		body.velocity.y -= 200
		death()

func _on_death_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if alive == true:
			body.health -=40
		death()

func death():
	alive = false
	chase = false # Остановка погони
	velocity.x = 0 # Мгновенная остановка
	anim.play("Death")
	# Ждем завершения анимации перед удалением
	await anim.animation_finished
	queue_free()


	pass # Replace with function body.
