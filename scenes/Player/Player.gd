extends CharacterBody3D

@onready var camera: Camera3D = $CameraController/Recoil/Camera3D
@onready var gun: Node3D = $CameraController/Recoil/Camera3D/Gun
@onready var gun_anim: AnimationPlayer = $CameraController/Recoil/Camera3D/Gun/AnimationPlayer

signal fire_acction_called

const SPEED: float = 5.0
const SPRINT_SPEED: float = 10.0
const JUMP_VELOCITY: float = 5
const MOUSE_SENS: float = 0.002
const EASE_FACTOR: float = 0.1
var CURRENT_SPEED: float = SPEED

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * MOUSE_SENS)
			camera.rotate_x(-event.relative.y * MOUSE_SENS)
			camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2)


func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= 12 * delta

	# Handle primary fire
	if Input.is_action_pressed("fire"):
		fire_acction_called.emit()
		gun_anim.play("shoot")

	# Handle sprint.
	if Input.is_action_pressed("sprint"):
		CURRENT_SPEED = SPRINT_SPEED
	else:
		CURRENT_SPEED = SPEED
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Apply easing to the velocity.
	if direction:
		velocity.x = lerp(velocity.x, direction.x * CURRENT_SPEED, EASE_FACTOR)
		velocity.z = lerp(velocity.z, direction.z * CURRENT_SPEED, EASE_FACTOR)
	else:
		velocity.x = lerp(velocity.x, 0.0, EASE_FACTOR)
		velocity.z = lerp(velocity.z, 0.0, EASE_FACTOR)

	# Move the character.
	move_and_slide()
