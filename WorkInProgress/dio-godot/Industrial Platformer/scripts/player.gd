extends CharacterBody2D


@export var speed = 15.0
@export_range(0, 1) var lerp_factor = 0.01

@onready var sprite = %Sprite
@onready var camera_2d = %Camera2D


#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var target_velocity = direction * speed * 100
	var target_rotation = direction.x * 30.0
	velocity = lerp(velocity, target_velocity, lerp_factor)
	move_and_slide()
	
	sprite.rotation_degrees = lerp(sprite.rotation_degrees, target_rotation, lerp_factor * 3)
	#sprite.skew = direction.x * 1
