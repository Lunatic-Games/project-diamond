extends Control


@onready var ability_panel = $AbilityPanel
@onready var capture_panel = $CapturePanel

var ability_processor = preload("res://combat/ability_processor.gd").new()
var is_wild_encounter: bool = false

@onready var player_side: Side = $PlayerSide
@onready var enemy_side: Side = $EnemySide


func init(enemy_party: Party, is_wild_encounter) -> void:
	self.is_wild_encounter = is_wild_encounter
	
	player_side.init(Player.party)
	player_side.defeated.connect(_on_player_side_defeated)
	
	enemy_side.init(enemy_party)
	enemy_side.defeated.connect(_on_enemy_side_defeated)


func _on_ability_panel_ability_selected(ability: Ability) -> void:
	player_side.new_turn()
	enemy_side.new_turn()
	
	ability_processor.process_ability(ability, player_side.active_fighter,
		enemy_side.active_fighter)
	
#	var enemy_ability: Ability = enemy_side.active_fighter.get_random_ability()
#	if enemy_ability:
#		ability_processor.process_ability(enemy_ability, enemy_side.active_fighter,
#			player_side.active_fighter)


func _on_player_side_defeated() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
	Player.respawn()


func _on_enemy_side_defeated() -> void:
	if is_wild_encounter:
		ability_panel.hide()
		capture_panel.show()
	else:
		get_tree().change_scene_to_file("res://world/world.tscn")


func _on_capture_panel_captured() -> void:
	Player.party.add_fighter(enemy_side.active_fighter, true)
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_capture_panel_got_away() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_capture_panel_released() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
