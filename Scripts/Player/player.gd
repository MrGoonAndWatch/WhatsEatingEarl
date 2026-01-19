extends CharacterBody3D

@export var player_speed: float = 250
@export var run_multiplier: float = 3
@export var rotating_parts: Node3D

const VERT_LOOK_CAP_DEG: float = 70

# TODO: MOVE THESE IN TO A CONFIG DATA STRUCT!!!
const MOUSE_SENSITIVITY: float = 0.01
const CONTROLLER_SENSITIVITY: float = 10

func _physics_process(delta: float) -> void:
	velocity = get_movement(delta)
	process_look(delta)
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		print("mouse capture x=%s, y=%s" % [event.relative.x, event.relative.y])
		rotate_camera(event.relative.x * MOUSE_SENSITIVITY, event.relative.y * MOUSE_SENSITIVITY)
	# elif event is InputEventJoypadMotion:
	#	print ("joypad motion captured %s" % [event])

func get_movement(delta: float) -> Vector3:
	var move_input = wee_constants.get_movement_vector()
	var is_running = Input.is_action_pressed(wee_constants.controls.run)
	var run_mult = 1
	if is_running:
		run_mult = run_multiplier
	var move_input_total = Vector3(move_input.x, 0, move_input.y) * delta * player_speed * run_mult
	return move_input_total.rotated(Vector3.UP, rotating_parts.global_rotation.y)

func process_look(delta: float) -> void:
	var look_input = wee_constants.get_look_vector()
	if look_input == Vector2.ZERO:
		return

func rotate_camera(x: float, y: float) -> void:
	if x == 0 && y == 0:
		return
	
	rotate_y(-x)
	rotating_parts.rotate_x(-y)
	rotating_parts.rotation.x = clampf(rotating_parts.rotation.x, -deg_to_rad(VERT_LOOK_CAP_DEG), deg_to_rad(VERT_LOOK_CAP_DEG))
