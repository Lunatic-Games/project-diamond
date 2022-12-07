extends Control


@export var ally_creature: Resource
@export var enemy_creature: Resource

@onready var ally_position := $AllyPosition
@onready var enemy_position := $EnemyPosition

var ally_sprite: Node2D
var enemy_sprite: Node2D


func _ready():
	if ally_creature:
		ally_sprite = ally_creature.sprite.instantiate()
		add_child(ally_sprite)
		ally_sprite.position = ally_position.position
	if enemy_creature:
		enemy_sprite = enemy_creature.sprite.instantiate()
		add_child(enemy_sprite)
		enemy_sprite.position = enemy_position.position


func _on_ability_panel_ability_selected(ability):
	print("Ability selected: ", ability)
