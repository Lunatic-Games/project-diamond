extends Area2D

@export_range(0.0, 1.0) var encounter_chance: float  # For moving one pixel
@export var minimum_amount_travelled: float

@export_group("Texturing")
@export var grass_texture: Texture
@export var grass_spacing: Vector2i = Vector2i(25, 25)
@export var grass_scale: int = 3

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
	if distance_travelled == 0.0:
		return
	
	_additive_distance_travelled += distance_travelled
	if _additive_distance_travelled < minimum_amount_travelled:
		return
	
	if randf_range(0.0, 1.0 / distance_travelled) < encounter_chance:
		get_tree().change_scene_to_file("res://combat/combat.tscn")
		_additive_distance_travelled = 0.0


func _draw():
	var area_shape := collision_shape.shape as RectangleShape2D
	assert(area_shape)
	assert(grass_texture)
	assert(grass_spacing.x > 0)
	assert(grass_spacing.y > 0)
	assert(grass_scale > 0)
	
	var area_size: Vector2 = area_shape.size
	var pos: Vector2 = collision_shape.position - area_size / 2.0
	
	for x in range(0, area_size.x, grass_spacing.x):
		for y in range(0, area_size.y, grass_spacing.y):
			draw_set_transform(pos + Vector2(x, y), 45.0, Vector2.ONE * grass_scale)
			draw_texture(grass_texture, Vector2.ZERO)

