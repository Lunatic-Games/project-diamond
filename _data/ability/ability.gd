extends Resource

class_name Ability

@export var name: String = ""
@export_group("Damage")
@export var damage_amount: int = 0
@export var min_number_of_hits: int = 1
@export var max_number_of_hits: int = 1
@export_range(0.0, 1.0) var life_vamp_ratio: float = 0.0

@export_group("Healing")
@export var heal_amount: int = 0
@export var full_heal: bool = false

@export_group("Status Effects")
@export_range(0.0, 1.0) var burn_ratio: float = 0.0
@export_range(0.0, 1.0) var paralyze_ratio: float = 0.0
