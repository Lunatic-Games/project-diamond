extends Node


const COMBAT = preload("res://combat/combat.tscn")
const WORLD = preload("res://world/world.tscn")


func to_combat(enemy_party: Party, is_wild_encounter: bool):
	var combat: Control = _switch_to_scene(COMBAT)
	combat.init(enemy_party, is_wild_encounter)


func to_world():
	_switch_to_scene(WORLD)


func _switch_to_scene(packed_scene: PackedScene) -> Node:
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
		
	var scene = packed_scene.instantiate()
	get_tree().root.add_child(scene)
	get_tree().current_scene = scene
	return scene
