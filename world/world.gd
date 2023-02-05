extends Node2D


const PLAYER_CHARACTER: PackedScene = preload("res://world/player_character/player_character.tscn")

var player_character: CharacterBody2D

@onready var location: Location = $StartLocation
@onready var party_view: GridContainer = $Overlay/PartyView
@onready var dialog_manager: DialogManager = $Overlay/DialogManager


func _ready() -> void:
	setup_location()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("view_party") and not party_view.visible:
		party_view.show()
		get_tree().paused = true
		get_viewport().set_input_as_handled()


func load_world_persistence() -> void:
	player_character.global_position = WorldPersistence.last_player_position


func setup_location() -> void:
	player_character = PLAYER_CHARACTER.instantiate()
	location.add_child(player_character)
	player_character.global_position = location.default_spawn_marker.global_position

	location.wild_encounter_triggered.connect(_on_location_wild_encounter_triggered)
	location.npc_interacted_with.connect(_on_npc_interacted_with)


func _on_location_wild_encounter_triggered(wild_party: Party) -> void:
	WorldPersistence.last_player_position = player_character.global_position
	
	SceneSwitcher.to_combat(wild_party, true)


func _on_npc_interacted_with(npc: NPC) -> void:
	if npc.dialog:
		for text in npc.dialog:
			dialog_manager.queue_text(text)
		await(dialog_manager.finished_all_text)
	
	if npc.is_hostile:
		WorldPersistence.last_player_position = player_character.global_position
		SceneSwitcher.to_combat(npc.get_party(), false)
