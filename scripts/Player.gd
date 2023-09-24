extends CharacterBody2D

@onready var weapons = $Weapons
@onready var sprite_2d = $Weapons/Sprite2D

const speed = 200  # Adjust the speed as needed
const gun_radius = 30 # Adjust the radius of the circular range

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
	
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")

	else:
		$AnimationTree.get("parameters/playback").travel("Walk")	
		$AnimationTree.set('parameters/Idle/blend_position', movement_direction)
		$AnimationTree.set('parameters/Walk/blend_position', movement_direction)
		move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		# Get the mouse position in global coordinates
		var mouse_pos = get_global_mouse_position()

		# Calculate the direction from the character to the mouse
		var direction = (mouse_pos - global_position).normalized()

		# Calculate the gun position within the circular range
		var gun_position = global_position + direction * gun_radius

		# Set the gun's position relative to the character
		weapons.global_position = gun_position

		# Look at the mouse position
		weapons.look_at(mouse_pos)

		if mouse_pos.x < weapons.global_position.x:
			sprite_2d.scale = Vector2(1, -1)
		elif mouse_pos.x > weapons.global_position.x:
			sprite_2d.scale = Vector2(1, 1)
