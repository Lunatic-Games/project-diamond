class_name HostileArea
extends Area2D

signal encounter_triggered

@export var possible_creatures: Array[Creature] = []
@export_range(0.0, 1.0) var encounter_chance: float  # For moving one pixel
@export var minimum_amount_travelled: float

@onready var collision_shape = $CollisionShape2D

var _player_in_area: bool = false
var _player_last_position: Vector2
var _additive_distance_travelled: float = 0.0


func _process(_delta):
	var player_detected = false
	
	for body in get_overlapping_bodies():
		if not body.is_in_group("PLAYER"):
			return
		player_detected = true
		
		if not _player_in_area:
			_player_in_area = true
			_player_last_position = body.global_position
			break
		
		check_for_encounter(_player_last_position.distance_to(body.global_position))
		_player_last_position = body.global_position
	
	if not player_detected:
		_player_in_area = false
		_additive_distance_travelled = 0.0


func check_for_encounter(distance_travelled: float):
	if distance_travelled == 0.0 or possible_creatures.is_empty():
		return
	
	_additive_distance_travelled += distance_travelled
	if _additive_distance_travelled < minimum_amount_travelled:
		return
	
	if randf_range(0.0, 1.0 / distance_travelled) < encounter_chance:
		emit_signal("encounter_triggered", possible_creatures.pick_random())
		_additive_distance_travelled = 0.0

