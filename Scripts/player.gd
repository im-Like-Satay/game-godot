extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -350.0
@onready var spriteAnimation = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		spriteAnimation.play("mainCharacterRun")
		
		if direction > 0:
			spriteAnimation.flip_h = false
		else:
			spriteAnimation.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		spriteAnimation.play("mainCharacterIdle")
	
	if not is_on_floor():
		spriteAnimation.play("mainCharacterJump")

	move_and_slide()


func _on_void_body_entered(body: Node2D) -> void:
	global_position = %SpawnPoint.global_position
