extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false

var speed = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var player = $"."
	var direction = (player.position - self.position).normalized()
	if chase == true:
		velocity.x = direction.x * speed
		
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true
