class_name wee_constants
extends Node

class controls:
	const move_forwards: String = "move_forwards"
	const move_backwards: String = "move_backwards"
	const strafe_left: String = "strafe_left"
	const strafe_right: String = "strafe_right"
	const look_up: String = "look_up"
	const look_down: String = "look_down"
	const look_left: String = "look_left"
	const look_right: String = "look_right"
	const run: String = "run"

# Could be a config value, though piping it through to the static methods in this class might be jank.
const GAMEPAD_DEADZONE: float = 0.1

static func get_movement_vector() -> Vector2:
	var move_vector = Input.get_vector(controls.strafe_left, controls.strafe_right, controls.move_forwards, controls.move_backwards)
	return apply_deadzone(move_vector, GAMEPAD_DEADZONE)

###
# ONLY WORKS FOR CONTROLLER LOOK AND KEYBOARD LOOK... 
# IDK WHY BUT I CAN'T BIND MOUSE MOVEMENTS TO INPUTS IN GODOT!!!
###
static func get_look_vector() -> Vector2:
	var look_vector = Input.get_vector(controls.look_left, controls.look_right, controls.look_up, controls.look_down)
	return apply_deadzone(look_vector, GAMEPAD_DEADZONE)

static func apply_deadzone(vec: Vector2, deadzone: float) -> Vector2:
	var x = vec.x
	var y = vec.y
	if abs(x) < deadzone:
		x = 0
	if abs(vec.y) < deadzone:
		y = 0
	return Vector2(x, y)
