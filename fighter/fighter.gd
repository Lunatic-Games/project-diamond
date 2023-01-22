class_name Fighter
extends Object


signal health_changed(amount: int)
signal died

var max_health: int
var current_health: int
var creature_scene: PackedScene
var known_abilities: Array[Ability]


func _init(creature: Creature) -> void:
	max_health = creature.max_health
	current_health = max_health
	creature_scene = creature.sprite_scene
	known_abilities = creature.default_abilities


func get_random_ability() -> Ability:
	assert(known_abilities.size() > 0, "Fighter has no abilities to choose from")
	return known_abilities.pick_random()


func take_damage(amount: int) -> int:
	assert(amount >= 0)
	
	var health_before: int = current_health
	current_health = clampi(current_health - amount, 0, max_health)
	
	var damage_dealt: int = health_before - current_health
	
	if damage_dealt:
		emit_signal("health_changed", -damage_dealt)
	if damage_dealt and current_health == 0:
		emit_signal("died")
	
	return damage_dealt


func heal(amount: int) -> int:
	# Should negative heal be allowed?
	# Will there be overheal?
	var health_before: int = current_health
	current_health = clampi(current_health + amount, 0, max_health)
	
	var health_healed: int = current_health - health_before
	
	if health_healed:
		emit_signal("health_changed", health_healed)
	
	return health_healed


func full_restore() -> void:
	current_health = max_health


func is_dead() -> bool:
	return current_health == 0
