extends Node2D


const PLAYER_CHARACTER = preload("res://world/player_character/player_character.tscn")

@onready var location: Location = $StartLocation
@onready var party_view = $Overlay/PartyView


func _ready():
	setup_location()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("view_party") and not party_view.visible:
		party_view.show()
		get_tree().paused = true
		get_viewport().set_input_as_handled()


func setup_location() -> void:
	var player_character: CharacterBody2D = PLAYER_CHARACTER.instantiate()
	location.add_child(player_character)
	player_character.global_position = location.default_spawn_marker.global_position

	for hostile_area in location.get_hostile_areas():
		hostile_area.encounter_triggered.connect(_on_hostile_area_encounter_triggered.bind())


func _on_hostile_area_encounter_triggered(creature: Creature) -> void:
	var enemy_fighter: Fighter = Fighter.new(creature)
	var enemy_party: Party = Party.new([enemy_fighter])
	
	SceneSwitcher.to_combat(enemy_party, true)
