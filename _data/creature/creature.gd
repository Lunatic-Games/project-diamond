class_name Creature
extends Resource


@export_placeholder("Name") var name: String = ""
@export_range(0, 999) var max_health: int = 1
@export var sprite_scene: PackedScene = null
@export var default_abilities: Array[Ability]


func _ready() -> void:
	assert(name, "Every creature should have a name")
	assert(sprite_scene, "Every creature should have a sprite scene")
