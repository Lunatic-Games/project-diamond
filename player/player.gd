extends Node


const MAX_PARTY_SIZE = 4

var character_name = "NAME"
var party: Array[Fighter] = []


func _ready():
	var bat = load("res://_data/creature/data/bat.tres")
	
	var starter = Fighter.new(bat)
	party.append(starter)
	
	var second = Fighter.new(bat)
	party.append(second)


func get_next_ready_fighter(ignored=[]):
	for fighter in party:
		if fighter not in ignored and not fighter.is_dead():
			return fighter
	return null


func respawn():
	for fighter in party:
		fighter.full_restore()


func is_party_full():
	return party.size() >= MAX_PARTY_SIZE


func add_to_party(fighter: Fighter):
	fighter.full_restore()
	party.append(fighter)
	print("Added to party")
