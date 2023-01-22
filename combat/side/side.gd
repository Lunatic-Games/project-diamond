class_name Side
extends Control

signal defeated

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


func new_turn() -> void:
	health_bar.reset_stats()


func set_new_active_fighter(fighter: Fighter) -> void:
	if sprite:
		sprite.queue_free()
	if active_fighter:
		unhook_active_fighter()
	
	active_fighter = fighter
	sprite = active_fighter.creature_scene.instantiate()
	add_child(sprite)
	sprite.global_position = spawn_marker.global_position
	
	hook_up_active_fighter()
	health_bar.update(active_fighter)


func hook_up_active_fighter() -> void:
	active_fighter.health_changed.connect(_on_active_fighter_health_changed)
	active_fighter.died.connect(_on_active_fighter_died)


func unhook_active_fighter() -> void:
	active_fighter.health_changed.disconnect(_on_active_fighter_health_changed)
	active_fighter.die.disconnect(_on_active_fighter_died)


func _on_active_fighter_health_changed(amount_changed: int):
	health_bar.update(active_fighter, amount_changed)


func _on_active_fighter_died() -> void:
	var next: Fighter = party.get_next_available_fighter()
	
	if next:
		print("Swapping out")
		unhook_active_fighter()
		sprite.queue_free()
		
		set_new_active_fighter(next)
		health_bar.reset_stats()
	else:
		defeated.emit()
