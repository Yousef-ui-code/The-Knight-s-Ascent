extends CharacterBody2D

# Constants for movement feel
const SPEED = 180.0
const JUMP_VELOCITY = -350.0
const ACCELERATION = 800.0
const FRICTION = 1000.0


# Reference the Sprite node to flip it and play animations
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. Add Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Variable Jump Height: If player releases jump button early, start falling
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	# 3. Get Input Direction (-1, 0, or 1)
	var direction := Input.get_axis("move_left", "move_right")
	
	# 4. Handle Movement and Friction
	if direction != 0:
		# Accelerate towards the direction
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		# Flip the sprite based on direction
		animated_sprite.flip_h = (direction < 0)
	else:
		# Slow down smoothly when no key is pressed
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	# 5. Handle Animations
	update_animations(direction)

	# 6. Apply Movement
	move_and_slide()

func update_animations(direction: float) -> void:
	if not is_on_floor():
		animated_sprite.play("jump")
	else:
		if direction != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
