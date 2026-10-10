extends CharacterBody3D
class_name Player

@onready var pivot: Node3D = $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

const SINE_FREQUENCY = 2.0
const SINE_AMPLITUDE = 0.08
var time_sine = 0.0


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	time_sine += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _pivot_sine(time_sine)

	move_and_slide()


func _pivot_sine(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * SINE_FREQUENCY) * SINE_AMPLITUDE
	pos.x = cos(time * SINE_FREQUENCY) * SINE_AMPLITUDE
	return pos
