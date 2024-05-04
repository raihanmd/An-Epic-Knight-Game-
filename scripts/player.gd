class_name Player extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var isAlive: bool = true
var direction: float
@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sfx = $jump_sfx

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sfx.play()
		velocity.y = JUMP_VELOCITY

	if isAlive:
		direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
			animated_sprite.flip_h = false
	elif direction < 0:
			animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
