extends Object

class_name Fighter

var max_health: int
var current_health: int

func _init(creature: Creature):
	max_health = creature.max_health
	current_health = max_health


func take_damage(amount: int):
	assert(amount >= 0)
	current_health = clampi(current_health - amount, 0, max_health)


func heal(amount):
	# Should negative heal be allowed?
	# Will there be overheal?
	current_health = clampi(current_health + amount, 0, max_health)
