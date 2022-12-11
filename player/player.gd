extends Node


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
