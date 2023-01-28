class_name NPC
extends StaticBody2D


signal encounter_triggered(Party)

@export var creatures_in_party: Array[Creature]


func _on_interact_area_interacted_with() -> void:
	assert(creatures_in_party, "NPC has no creatures for an encounter")
	
	var party: Party = Party.new()
	
	for creature in creatures_in_party:
		var fighter: Fighter = Fighter.new(creature)
		party.add_fighter(fighter)
		
	encounter_triggered.emit(party)
