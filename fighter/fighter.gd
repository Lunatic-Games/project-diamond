extends Object

class_name Fighter

signal health_changed(amount: int)
signal died

var max_health: int
var current_health: int
var creature_scene: PackedScene


func _init(creature: Creature):
	max_health = creature.max_health
	current_health = max_health
	creature_scene = creature.sprite_scene


func take_damage(amount: int) -> int:
	assert(amount >= 0)
	var health_before = current_health
	
	current_health = clampi(current_health - amount, 0, max_health)
	
	var damage_dealt = health_before - current_health
	if damage_dealt:
		emit_signal("health_changed", -damage_dealt)
	
	if damage_dealt and current_health == 0:
		emit_signal("died")
	
	return damage_dealt


func heal(amount) -> int:
	# Should negative heal be allowed?
	# Will there be overheal?
	var health_before = current_health
	
	current_health = clampi(current_health + amount, 0, max_health)
	
	var health_healed = current_health - health_before
	if health_healed:
		emit_signal("health_changed", health_healed)
	
	return health_healed


func full_restore():
	current_health = max_health


func is_dead():
	return current_health == 0
