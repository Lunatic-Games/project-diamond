class_name Party
extends Node


const MAX_SIZE: int = 4

var fighters: Array[Fighter] = []


func _init(fighters_in_party: Array[Fighter]) -> void:
	for fighter in fighters_in_party:
		add_fighter(fighter)


func add_fighter(fighter: Fighter, should_full_restore_fighter: bool = false) -> void:
	assert(fighters.size() <= MAX_SIZE, "Trying to add a fighter to a full party")
	assert(!fighters.has(fighter), "Trying to add a fighter to party it is already in")
	
	fighters.append(fighter)
	if should_full_restore_fighter:
		fighter.full_restore()


func remove_fighter(fighter: Fighter) -> void:
	assert(fighter in fighters, "Trying to remove a fighter from a party that it isn't in")


func get_next_available_fighter(ignore_list: Array = []) -> Fighter:
	for fighter in fighters:
		if fighter not in ignore_list and not fighter.is_dead():
			return fighter
	return null


func get_size() -> int:
	return fighters.size()


func full_restore() -> void:
	for fighter in fighters:
		fighter.full_restore()


func is_full() -> bool:
	assert(fighters.size() <= MAX_SIZE, "Party has more than the max party size")
	return fighters.size() >= MAX_SIZE
