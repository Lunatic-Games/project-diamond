class_name HostileArea
extends Area2D

signal encounter_triggered

@export var possible_creatures: Array[Creature] = []
@export_range(0.0, 1.0) var encounter_chance: float  # For moving one pixel
@export var minimum_amount_travelled: float

var player_in_area: bool = false
var _player_last_position: Vector2
var _additive_distance_travelled: float = 0.0


func _process(_delta):
	var is_player_detected: bool = false
	
	for body in get_overlapping_bodies():
		if not body.is_in_group("PLAYER"):
			return
		
		is_player_detected = true
		if player_in_area:
			check_for_encounter(_player_last_position.distance_to(body.global_position))
		_player_last_position = body.global_position
	
	player_in_area = is_player_detected


func check_for_encounter(distance_travelled: float):
	if distance_travelled == 0.0 or possible_creatures.is_empty():
		return
	
	_additive_distance_travelled += distance_travelled
	if _additive_distance_travelled < minimum_amount_travelled:
		return
	
	if randf_range(0.0, 1.0 / distance_travelled) < encounter_chance:
		encounter_triggered.emit(possible_creatures.pick_random())
		_additive_distance_travelled = 0.0

