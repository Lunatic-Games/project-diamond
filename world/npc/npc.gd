class_name NPC
extends StaticBody2D


signal interacted_with

@export var dialog: Array[String]
@export_group("Combat")
@export var is_hostile: bool = false
@export var creatures_in_party: Array[Creature]


func _ready():
	assert(!is_hostile or creatures_in_party.size() > 0, 
		"Hostile NPC does not have a party specified.")


func get_party() -> Party:
	assert(creatures_in_party, "NPC has no creatures for an encounter")
	var party: Party = Party.new()
	
	for creature in creatures_in_party:
		var fighter: Fighter = Fighter.new(creature)
		party.add_fighter(fighter)
		
	return party


func _on_interact_area_interacted_with() -> void:
	interacted_with.emit()
