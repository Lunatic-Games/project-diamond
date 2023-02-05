extends Control


const ENEMY_ATTACK_OVERRIDE = preload("res://_data/ability/data/wing_slash.tres")

var is_wild_encounter: bool = false

@onready var player_side: Side = $PlayerSide
@onready var enemy_side: Side = $EnemySide

@onready var ability_panel = $AbilityPanel
@onready var capture_panel = $CapturePanel

@onready var dialog_manager: Control = $DialogManager
@onready var ability_processor: Control = $AbilityProcessor


func init(enemy_party: Party, is_combat_wild_encounter) -> void:
	is_wild_encounter = is_combat_wild_encounter
	ability_processor.dialog_manager = dialog_manager
	
	# TODO: Better system for having ally vs. enemy names
	player_side.init(Player.party, "ALLY CREATURE")
	enemy_side.init(enemy_party, "ENEMY CREATURE")


func _on_ability_panel_ability_selected(ability: Ability) -> void:
	ability_panel.hide()
	
	# Process player turn
	ability_processor.process_ability(ability, player_side.active_fighter,
		enemy_side.active_fighter)
	await(ability_processor.processing_done)
	
	if enemy_side.is_active_fighter_dead():
		await(dialog_manager.display_and_wait(enemy_side.get_death_text()))
		var has_next_fighter = enemy_side.has_next_fighter()
		if has_next_fighter:
			enemy_side.next_available_fighter()
			await(dialog_manager.display_and_wait(enemy_side.get_new_fighter_text()))
			ability_panel.show()
		else:
			_on_enemy_side_defeated()
		return
	
	# Process enemy turn
	#var enemy_ability: Ability = enemy_side.active_fighter.get_random_ability()
	var enemy_ability: Ability = ENEMY_ATTACK_OVERRIDE
	ability_processor.process_ability(enemy_ability, enemy_side.active_fighter,
		player_side.active_fighter)
	await(ability_processor.processing_done)
	
	if player_side.is_active_fighter_dead():
		await(dialog_manager.display_and_wait(player_side.get_death_text()))
		var has_next_fighter = player_side.has_next_fighter()
		if has_next_fighter:
			player_side.next_available_fighter()
			await(dialog_manager.display_and_wait(player_side.get_new_fighter_text()))
		else:
			_on_player_side_defeated()
			return
	
	# Back to player
	ability_panel.show()


func _on_player_side_defeated() -> void:
	await(dialog_manager.display_and_wait("You were defeated..."))
	SceneSwitcher.to_world()
	Player.respawn()


func _on_enemy_side_defeated() -> void:
	if is_wild_encounter:
		ability_panel.hide()
		capture_panel.show()
	else:
		await(dialog_manager.display_and_wait("You defeated the enemy!"))
		SceneSwitcher.to_world()


func _on_capture_panel_captured() -> void:
	capture_panel.hide()
	await(dialog_manager.display_and_wait("Capture was successful!"))
	Player.party.add_fighter(enemy_side.active_fighter, true)
	SceneSwitcher.to_world()


func _on_capture_panel_got_away() -> void:
	capture_panel.hide()
	await(dialog_manager.display_and_wait("It got away..."))
	SceneSwitcher.to_world()


func _on_capture_panel_released() -> void:
	capture_panel.hide()
	await(dialog_manager.display_and_wait("The creature was released back into the wild."))
	SceneSwitcher.to_world()
