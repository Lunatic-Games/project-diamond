extends Control


@export var enemy_creature: Resource
@export var enemy_ability: Ability

@onready var ally_position := $AllyPosition
@onready var enemy_position := $EnemyPosition

@onready var ally_health_bar := $HealthBars/AllyHealthBar
@onready var enemy_health_bar := $HealthBars/EnemyHealthBar
@onready var ability_processor = $AbilityProcessor

var ally_fighter: Fighter
var enemy_fighter: Fighter

var ally_sprite: Node2D
var enemy_sprite: Node2D

var is_wild_encounter = false


func _ready():
	start_combat()

func start_combat():
	ally_fighter = Player.get_next_ready_fighter()
	assert(ally_fighter != null)
	ally_sprite = instantiate_fighter(ally_fighter, ally_position.position)
	
	if enemy_creature:
		enemy_fighter = Fighter.new(enemy_creature)
		enemy_sprite = instantiate_fighter(enemy_fighter, enemy_position.position)


func instantiate_fighter(fighter: Fighter, pos: Vector2) -> Node2D:
	var sprite = fighter.creature_scene.instantiate()
	add_child(sprite)
	sprite.position = pos
	
	fighter.health_changed.connect(_on_fighter_health_changed.bind(fighter))
	fighter.died.connect(_on_fighter_died.bind(fighter))
	_on_fighter_health_changed(0, fighter)
	
	return sprite


func unhook_fighter(fighter: Fighter):
	fighter.health_changed.disconnect(_on_fighter_health_changed)
	fighter.died.disconnect(_on_fighter_died)


func _on_ability_panel_ability_selected(ability: Ability):
	ally_health_bar.reset_stats()
	enemy_health_bar.reset_stats()
	
	ability_processor.process_ability(ability, ally_fighter, enemy_fighter)
	if enemy_ability:
		ability_processor.process_ability(enemy_ability, enemy_fighter, ally_fighter)

	
func _on_fighter_health_changed(amount_changed: int, fighter: Fighter):
	if fighter == ally_fighter:
		ally_health_bar.update(amount_changed, fighter)
	elif fighter == enemy_fighter:
		enemy_health_bar.update(amount_changed, fighter)


func _on_fighter_died(_fighter: Fighter):
	if _fighter == ally_fighter:
		var next = Player.get_next_ready_fighter([ally_fighter])
		if next:
			print("Swapping out")
			unhook_fighter(ally_fighter)
			ally_fighter = next
			ally_sprite.queue_free()
			ally_sprite = instantiate_fighter(ally_fighter, ally_position.position)
			ally_health_bar.reset_stats()
			return
		
		print("LOST")
		Player.respawn()
	
	get_tree().change_scene_to_file("res://world/world.tscn")
