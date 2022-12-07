extends Control


@export var ally_creature: Resource
@export var enemy_creature: Resource

@onready var ally_position := $AllyPosition
@onready var enemy_position := $EnemyPosition

@onready var ally_health_bar := $HealthBars/AllyHealthBar
@onready var enemy_health_bar := $HealthBars/EnemyHealthBar

var ally_fighter: Fighter
var enemy_fighter: Fighter

var ally_sprite: Node2D
var enemy_sprite: Node2D


func _ready():
	if ally_creature:
		ally_sprite = ally_creature.sprite.instantiate()
		add_child(ally_sprite)
		ally_sprite.position = ally_position.position
		
		ally_fighter = Fighter.new(ally_creature)
		ally_fighter.take_damage(5)
		update_health_bar(ally_health_bar, ally_fighter)
	
	if enemy_creature:
		enemy_sprite = enemy_creature.sprite.instantiate()
		add_child(enemy_sprite)
		enemy_sprite.position = enemy_position.position
		
		enemy_fighter = Fighter.new(enemy_creature)
		update_health_bar(enemy_health_bar, enemy_fighter)


func _on_ability_panel_ability_selected(ability):
	if ability == "Heal":
		heal_fighter(ally_fighter, 1)
	else:
		damage_fighter(enemy_fighter, 1)


func damage_fighter(fighter, amount):
	assert(fighter in [ally_fighter, enemy_fighter], "trying to deal damage to an unknown fighter")
	
	if fighter == ally_fighter:
		ally_fighter.take_damage(amount)
		update_health_bar(ally_health_bar, ally_fighter)
	
	elif fighter == enemy_fighter:
		enemy_fighter.take_damage(amount)
		update_health_bar(enemy_health_bar, enemy_fighter)


func heal_fighter(fighter, amount):
	assert(fighter in [ally_fighter, enemy_fighter], "trying to heal an unknown fighter")
	
	if fighter == ally_fighter:
		ally_fighter.heal(amount)
		update_health_bar(ally_health_bar, ally_fighter)
	
	elif fighter == enemy_fighter:
		enemy_fighter.heal(amount)
		update_health_bar(enemy_health_bar, enemy_fighter)
	
func update_health_bar(health_bar: ProgressBar, fighter: Fighter):
	var ratio = float(fighter.current_health) / float(fighter.max_health)
	health_bar.value = ratio * 100.0
