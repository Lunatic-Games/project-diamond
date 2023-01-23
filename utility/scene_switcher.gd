extends Node


const COMBAT: PackedScene = preload("res://combat/combat.tscn")
const WORLD: PackedScene = preload("res://world/world.tscn")


func to_combat(enemy_party: Party, is_wild_encounter: bool):
	var combat: Control = _switch_to_scene(COMBAT)
	combat.init(enemy_party, is_wild_encounter)


func to_world():
	var world: Node2D = _switch_to_scene(WORLD)
	world.load_world_persistence()


func _switch_to_scene(packed_scene: PackedScene) -> Node:
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
		
	var scene = packed_scene.instantiate()
	get_tree().root.add_child(scene)
	get_tree().current_scene = scene
	return scene
