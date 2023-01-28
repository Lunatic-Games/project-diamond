extends Control


const ENEMY_ATTACK_OVERRIDE = preload("res://_data/ability/data/wing_slash.tres")

var is_wild_encounter: bool = false

@onready var player_side: Side = $PlayerSide
@onready var enemy_side: Side = $EnemySide

@onready var ability_panel = $AbilityPanel
@onready var capture_panel = $CapturePanel

@onready var ability_processor: Control = $AbilityProcessor


func init(enemy_party: Party, is_combat_wild_encounter) -> void:
	is_wild_encounter = is_combat_wild_encounter
	
	player_side.init(Player.party)
	enemy_side.init(enemy_party)


func _on_ability_panel_ability_selected(ability: Ability) -> void:
	ability_panel.hide()
	
	# TODO: Un-hack this
	player_side.active_fighter.name = "ALLY CREATURE"
	enemy_side.active_fighter.name = "ENEMY CREATURE"
	
	ability_processor.process_ability(ability, player_side.active_fighter,
		enemy_side.active_fighter)
	await(ability_processor.processing_done)
	
	if enemy_side.is_active_fighter_dead():
		var has_next_fighter = enemy_side.try_next_fighter()
		if has_next_fighter:
			ability_panel.show()
		else:
			_on_enemy_side_defeated()
		return
	
	#var enemy_ability: Ability = enemy_side.active_fighter.get_random_ability()
	var enemy_ability: Ability = ENEMY_ATTACK_OVERRIDE
	ability_processor.process_ability(enemy_ability, enemy_side.active_fighter,
		player_side.active_fighter)
	await(ability_processor.processing_done)
	
	if player_side.is_active_fighter_dead():
		var has_next_fighter = player_side.try_next_fighter()
		if !has_next_fighter:
			_on_player_side_defeated()
			return
	
	ability_panel.show()


func _on_player_side_defeated() -> void:
	SceneSwitcher.to_world()
	Player.respawn()


func _on_enemy_side_defeated() -> void:
	if is_wild_encounter:
		ability_panel.hide()
		capture_panel.show()
	else:
		SceneSwitcher.to_world()


func _on_capture_panel_captured() -> void:
	Player.party.add_fighter(enemy_side.active_fighter, true)
	SceneSwitcher.to_world()


func _on_capture_panel_got_away() -> void:
	SceneSwitcher.to_world()


func _on_capture_panel_released() -> void:
	SceneSwitcher.to_world()
