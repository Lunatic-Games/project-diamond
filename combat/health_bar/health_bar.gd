extends ProgressBar


@onready var damage_dealt_label := $Stats/DamageDealt
@onready var health_healed_label := $Stats/HealthHealed


var damage_taken_this_turn = 0
var health_healed_this_turn = 0


func _ready():
	reset_stats()


func reset_stats():
	damage_taken_this_turn = 0
	health_healed_this_turn = 0
	health_healed_label.hide()
	damage_dealt_label.hide()


func update(health_difference: int, fighter: Fighter):
	var ratio = float(fighter.current_health) / float(fighter.max_health)
	value = ratio * 100.0
	
	if health_difference > 0:
		health_healed_this_turn += health_difference
		health_healed_label.text = "+" + str(health_healed_this_turn)
		health_healed_label.show()
	
	elif health_difference < 0:
		damage_taken_this_turn += -health_difference
		damage_dealt_label.text = "-" + str(damage_taken_this_turn)
		damage_dealt_label.show()
