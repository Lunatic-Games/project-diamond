extends CharacterBody2D


const MAX_SPEED: float = 250.0
const MOVE_ACCELERATION: float = 2.0

func _physics_process(delta: float) -> void:
	var h_axis = Input.get_axis("move_left", "move_right")
	var v_axis = Input.get_axis("move_up", "move_down")
	var movement_input = Vector2(h_axis, v_axis).normalized()
	velocity = velocity.move_toward(movement_input * MAX_SPEED, 
		MOVE_ACCELERATION * delta * 1000.0)
	
	move_and_slide()
