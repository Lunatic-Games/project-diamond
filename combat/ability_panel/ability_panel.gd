extends ColorRect

signal ability_selected(ability: Ability)

const ABILITY_BUTTON = preload("res://combat/ability_panel/ability_button.tscn")
const MAX_NUM_ABILITIES = 4

@export var abilities: Array[Ability]

@onready var grid_container := $MarginContainer/GridContainer


func _ready():
	assert(abilities.size() <= MAX_NUM_ABILITIES)
	
	for ability in abilities:
		var button = ABILITY_BUTTON.instantiate()
		button.text = ability.name
		grid_container.add_child(button)
		button.connect("pressed", _on_ability_button_pressed.bind(button, ability))


func _on_ability_button_pressed(_button: Button, ability: Ability):
	emit_signal("ability_selected", ability)
