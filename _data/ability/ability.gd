class_name Ability
extends Resource


@export_placeholder("Name") var name: String = ""
@export_group("Damage")
@export_range(0, 999) var damage_amount: int = 0
@export_range(0, 999) var min_number_of_hits: int = 1
@export_range(0, 999) var max_number_of_hits: int = 1
@export_range(0.0, 1.0) var life_vamp_ratio: float = 0.0

@export_group("Healing")
@export_range(0, 999) var heal_amount: int = 0
@export var full_heal: bool = false

@export_group("Status Effects")
@export_range(0.0, 1.0) var burn_probability: float = 0.0
@export_range(0.0, 1.0) var paralyze_probability: float = 0.0


func _ready() -> void:
	assert(name, "Every ability should have a name")
	assert(!full_heal or !heal_amount, "Either full heal or a heal amount should be specified, not both")
	assert(max_number_of_hits >= min_number_of_hits, "Max number of hits should be greater than min number")
