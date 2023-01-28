extends ProgressBar


const UPDATE_SPEED = 20.0

var target_value: float


func _physics_process(delta: float):
	value = lerpf(value, target_value, UPDATE_SPEED * delta)


func instant_update(fighter: Fighter):
	target_value = 100.0 * float(fighter.current_health) / float(fighter.max_health)
	value = target_value


func update(fighter: Fighter) -> void:
	target_value = 100.0 * float(fighter.current_health) / float(fighter.max_health)
