class_name Location
extends Node2D


@onready var default_spawn_marker: Marker2D = $DefaultSpawnMarker


func _ready() -> void:
	if get_tree().current_scene == self:
		pass


func get_hostile_areas() -> Array[HostileArea]:
	var hostile_areas: Array[HostileArea] = []
	
	for hostile_area in get_tree().get_nodes_in_group("HOSTILE_AREA"):
		if is_ancestor_of(hostile_area):
			hostile_areas.append(hostile_area)
	
	return hostile_areas


func get_npcs() -> Array[NPC]:
	var npcs: Array[NPC] = []
	
	for npc in get_tree().get_nodes_in_group("NPC"):
		if is_ancestor_of(npc):
			npcs.append(npc)
	
	return npcs
