extends Node


enum DIRECTION {UP, RIGHT, DOWN, LEFT}

const INPUT_ACTIONS = {
	DIRECTION.UP: "move_up",
	DIRECTION.RIGHT: "move_right",
	DIRECTION.DOWN: "move_down",
	DIRECTION.LEFT: "move_left"
}

@export var max_speed: float = 250.0
@export var acceleration_time: float = 0.5
@export var deceleration_time: float = 0.5
@export var acceleration_curve: Curve
@export var deceleration_curve: Curve

var _move_start_times_ms = {
	DIRECTION.UP: NAN,
	DIRECTION.RIGHT: NAN,
	DIRECTION.DOWN: NAN,
	DIRECTION.LEFT: NAN
}


func _ready():
	assert(acceleration_curve)
	assert(deceleration_curve)
	assert(max_speed >= 0.0)
	assert(acceleration_time >= 0.0)
	assert(deceleration_time >= 0.0)


func get_new_velocity(current_velocity: Vector2) -> Vector2:
	var h_input: float = Input.get_axis(INPUT_ACTIONS[DIRECTION.LEFT],
		INPUT_ACTIONS[DIRECTION.RIGHT])
	var v_input: float = Input.get_axis(INPUT_ACTIONS[DIRECTION.UP],
		INPUT_ACTIONS[DIRECTION.DOWN])
	var input_vector := Vector2(h_input, v_input).normalized()

	if input_vector.x > 0.0:
		_move_start_times_ms[DIRECTION.LEFT] = NAN
		if _move_start_times_ms[DIRECTION.RIGHT] == NAN:
			_move_start_times_ms = Time.get_ticks_msec()
		
		var time_passed = Time.get_ticks_msec() - _move_start_times_ms[DIRECTION.RIGHT]
	
	return input_vector * max_speed
