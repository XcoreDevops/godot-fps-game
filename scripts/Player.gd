extends KinematicBody

var speed = 10
var gravity = -9.8
var jump_speed = 20
var mouse_sensitivity = 0.1

var velocity = Vector3()
var mouse_delta = Vector2()

onready var camera = $Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

func _process(delta):
	var mouse_movement = mouse_delta * mouse_sensitivity
	rotate_y(deg2rad(-mouse_movement.x))
	camera.rotate_x(deg2rad(-mouse_movement.y))
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
	mouse_delta = Vector2()

func _physics_process(delta):
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()
	velocity.y += gravity * delta

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	velocity = move_and_slide(velocity, Vector3.UP)
