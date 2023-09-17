extends CharacterBody2D

const speed = 200  # Adjust the speed as needed

func _physics_process(_delta):
	var movement_direction = Vector2.ZERO

	# Input handling for movement
	if Input.is_action_pressed("left"):
		movement_direction.x -= 1
	if Input.is_action_pressed("right"):
		movement_direction.x += 1
	if Input.is_action_pressed("up"):
		movement_direction.y -= 1
	if Input.is_action_pressed("down"):
		movement_direction.y += 1

	movement_direction = movement_direction.normalized()
	velocity = movement_direction * speed
	move_and_slide()

