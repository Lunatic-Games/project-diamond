class_name Location
extends Node2D

signal wild_encounter_triggered(Party)
signal npc_interacted_with(NPC)

@onready var default_spawn_marker: Marker2D = $DefaultSpawnMarker


func _ready():
	for hostile_area in get_tree().get_nodes_in_group("HOSTILE_AREA"):
		if is_ancestor_of(hostile_area):
			hostile_area.encounter_triggered.connect(_on_hostile_area_encounter_triggered)
	
	for npc in get_tree().get_nodes_in_group("NPC"):
		if is_ancestor_of(npc):
			npc.interacted_with.connect(_on_npc_interacted_with.bind(npc))


func _on_hostile_area_encounter_triggered(party: Party) -> void:
	wild_encounter_triggered.emit(party)


func _on_npc_interacted_with(npc: NPC) -> void:
	npc_interacted_with.emit(npc)
