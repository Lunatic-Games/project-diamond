extends Node2D


const PLAYER_CHARACTER: PackedScene = preload("res://world/player_character/player_character.tscn")

var player_character: CharacterBody2D

@onready var location: Location = $StartLocation
@onready var party_view: GridContainer = $Overlay/PartyView


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

	for hostile_area in location.get_hostile_areas():
		hostile_area.encounter_triggered.connect(_on_hostile_area_encounter_triggered)
		
	for npc in location.get_npcs():
		npc.encounter_triggered.connect(_on_npc_encounter_triggered)


func _on_hostile_area_encounter_triggered(creature: Creature) -> void:
	WorldPersistence.last_player_position = player_character.global_position
	
	var enemy_fighter: Fighter = Fighter.new(creature)
	var enemy_party: Party = Party.new([enemy_fighter])
	
	SceneSwitcher.to_combat(enemy_party, true)


func _on_npc_encounter_triggered(npc_party: Party) -> void:
	WorldPersistence.last_player_position = player_character.global_position
	
	SceneSwitcher.to_combat(npc_party, false)
