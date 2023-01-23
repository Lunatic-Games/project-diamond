extends ColorRect

signal ability_selected(ability: Ability)

const ABILITY_BUTTON = preload("res://combat/ability_panel/ability_button.tscn")
const MAX_NUM_ABILITIES: int = 4

@export var abilities: Array[Ability]

@onready var grid_container: GridContainer = $MarginContainer/GridContainer


func _ready() -> void:
	assert(abilities.size() <= MAX_NUM_ABILITIES)
	
	for ability in abilities:
		var button: Button = ABILITY_BUTTON.instantiate()
		button.text = ability.name
		grid_container.add_child(button)
		button.connect("pressed", _on_ability_button_pressed.bind(button, ability))


func _on_ability_button_pressed(_button: Button, ability: Ability) -> void:
	ability_selected.emit(ability)
