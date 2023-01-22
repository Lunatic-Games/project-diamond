extends ProgressBar


@onready var damage_dealt_label: Label = $Stats/DamageDealt
@onready var health_healed_label: Label = $Stats/HealthHealed


var damage_taken_this_turn: int = 0
var health_healed_this_turn: int = 0


func _ready() -> void:
	reset_stats()


func reset_stats() -> void:
	damage_taken_this_turn = 0
	health_healed_this_turn = 0
	health_healed_label.hide()
	damage_dealt_label.hide()


func update(fighter: Fighter, health_difference: int = 0) -> void:
	value = 100.0 * float(fighter.current_health) / float(fighter.max_health)
	
	if health_difference > 0:
		health_healed_this_turn += health_difference
		health_healed_label.text = "+" + str(health_healed_this_turn)
		health_healed_label.show()
	
	elif health_difference < 0:
		damage_taken_this_turn += -health_difference
		damage_dealt_label.text = "-" + str(damage_taken_this_turn)
		damage_dealt_label.show()
