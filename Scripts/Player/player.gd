extends CharacterBody3D

@export var player_speed: float = 250
@export var run_multiplier: float = 3
@export var rotating_parts: Node3D

const VERT_LOOK_CAP_DEG: float = 70

# TODO: MOVE THESE IN TO A CONFIG DATA STRUCT!!!
const MOUSE_SENSITIVITY: float = 0.01
const GAMEPAD_LOOK_SENSITIVITY: float = 10

func _physics_process(delta: float) -> void:
	velocity = get_movement(delta)
	process_look(delta)
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and event.relative != Vector2.ZERO:
		# print("mouse capture %s" % [event.relative])
		var mouse_dir = event.relative * MOUSE_SENSITIVITY
		rotate_camera(mouse_dir)
	# This works but ew.
	# elif (event is InputEventJoypadMotion 
	#	and abs(event.axis_value) > GAMEPAD_DEADZONE):
	#	print ("joypad motion captured %s" % [event])
	#	if event.axis == RSTICK_H_AXISID: # 2
	#		rotate_camera(event.axis_value, 0)
	#	elif event.axis == RSTICK_V_AXISID: # 3
	#		rotate_camera(0, event.axis_value)

func get_movement(delta: float) -> Vector3:
	var move_input = wee_constants.get_movement_vector()
	var is_running = Input.is_action_pressed(wee_constants.controls.run)
	var run_mult = 1
	if is_running:
		run_mult = run_multiplier
	var move_input_total = Vector3(move_input.x, 0, move_input.y) * delta * player_speed * run_mult
	return move_input_total.rotated(Vector3.UP, rotating_parts.global_rotation.y)

# Note: Mouse look is handled by _input(), this only handles keyboard/gamepad input.
func process_look(delta: float) -> void:
	var look_input = wee_constants.get_look_vector()
	if look_input == Vector2.ZERO:
		return
	
	look_input *= delta * GAMEPAD_LOOK_SENSITIVITY
	rotate_camera(look_input)

func rotate_camera(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		return
	
	rotate_y(-dir.x)
	rotating_parts.rotate_x(-dir.y)
	rotating_parts.rotation.x = clampf(rotating_parts.rotation.x, -deg_to_rad(VERT_LOOK_CAP_DEG), deg_to_rad(VERT_LOOK_CAP_DEG))
