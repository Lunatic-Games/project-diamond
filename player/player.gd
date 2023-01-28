extends Node


var party: Party = Party.new()


func _ready() -> void:
	var bat = load("res://_data/creature/data/bat.tres")
	
	var starter = Fighter.new(bat)
	party.add_fighter(starter)
	
	var second = Fighter.new(bat)
	party.add_fighter(second)


func respawn() -> void:
	party.full_restore()
