class_name Side
extends Control


var party: Party
var active_fighter: Fighter
var sprite: Node2D

var _fighter_name_override = ""

@onready var health_bar: ProgressBar = $HealthBar
@onready var spawn_marker: Marker2D = $SpawnMarker


func init(new_party: Party, name_override: String = "") -> void:
	assert(party == null, "This should only be initialized once")
	party = new_party
	_fighter_name_override = name_override
	
	var starting_fighter: Fighter = party.get_next_available_fighter()
	assert(starting_fighter)
	set_new_active_fighter(starting_fighter)


func is_active_fighter_dead() -> bool:
	assert(active_fighter)
	
	return active_fighter.is_dead()


func has_next_fighter() -> bool:
	return party.has_next_available_fighter()


func next_available_fighter() -> void:
	var next_fighter = party.get_next_available_fighter()
	assert(next_fighter)
	
	set_new_active_fighter(next_fighter)


func set_new_active_fighter(fighter: Fighter) -> void:
	assert(!fighter.is_dead(), "New active fighter is already dead")
	
	if sprite:
		sprite.queue_free()
	if active_fighter:
		_unhook_active_fighter()
	
	active_fighter = fighter
	if _fighter_name_override:
		active_fighter.name = _fighter_name_override
	sprite = active_fighter.creature_scene.instantiate()
	add_child(sprite)
	sprite.global_position = spawn_marker.global_position
	
	_hook_up_active_fighter()
	health_bar.instant_update(active_fighter)


func get_death_text() -> String:
	assert(active_fighter and active_fighter.is_dead())
	return "{0} was knocked out!".format([active_fighter.name])


func get_new_fighter_text() -> String:
	assert(active_fighter and !active_fighter.is_dead())
	return "{0} has entered the battle!".format([active_fighter.name])


func _hook_up_active_fighter() -> void:
	active_fighter.health_changed.connect(_on_active_fighter_health_changed)


func _unhook_active_fighter() -> void:
	active_fighter.health_changed.disconnect(_on_active_fighter_health_changed)


func _on_active_fighter_health_changed(_amount_changed: int):
	health_bar.update(active_fighter)
