class_name Side
extends Control


var party: Party
var active_fighter: Fighter
var sprite: Node2D

@onready var health_bar: ProgressBar = $HealthBar
@onready var spawn_marker: Marker2D = $SpawnMarker


func init(new_party: Party) -> void:
	assert(party == null, "This should only be initialized once")
	party = new_party
	
	var starting_fighter: Fighter = party.get_next_available_fighter()
	assert(starting_fighter)
	set_new_active_fighter(starting_fighter)


func is_active_fighter_dead() -> bool:
	assert(active_fighter)
	
	return active_fighter.is_dead()


func try_next_fighter() -> bool:
	assert(active_fighter)
	
	var next: Fighter = party.get_next_available_fighter()
	
	if next:
		set_new_active_fighter(next)
		return true
	
	return false


func set_new_active_fighter(fighter: Fighter) -> void:
	if sprite:
		sprite.queue_free()
	if active_fighter:
		_unhook_active_fighter()
	
	active_fighter = fighter
	sprite = active_fighter.creature_scene.instantiate()
	add_child(sprite)
	sprite.global_position = spawn_marker.global_position
	
	_hook_up_active_fighter()
	health_bar.instant_update(active_fighter)


func _hook_up_active_fighter() -> void:
	active_fighter.health_changed.connect(_on_active_fighter_health_changed)


func _unhook_active_fighter() -> void:
	active_fighter.health_changed.disconnect(_on_active_fighter_health_changed)


func _on_active_fighter_health_changed(_amount_changed: int):
	health_bar.update(active_fighter)
