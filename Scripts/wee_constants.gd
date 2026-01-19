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

static func get_movement_vector() -> Vector2:
	return Input.get_vector(controls.strafe_left, controls.strafe_right, controls.move_forwards, controls.move_backwards)

###
# ONLY WORKS FOR CONTROLLER LOOK AND KEYBOARD LOOK... IDK WHY BUT I CAN'T BIND MOUSE MOVEMENTS TO INPUTS IN GODOT!!!
###
static func get_look_vector() -> Vector2:
	return Input.get_vector(controls.look_left, controls.look_right, controls.look_up, controls.look_down)
