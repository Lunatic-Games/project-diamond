class_name InteractArea
extends Area2D


signal interacted_with

var is_player_in_area: bool = false

@onready var prompt: Label = $Prompt


func _ready():
	prompt.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_in_area:
		emit_signal("interacted_with")


func _on_body_entered(body):
	if not body.is_in_group("PLAYER"):
		return
	
	is_player_in_area = true
	prompt.show()


func _on_body_exited(body):
	if not body.is_in_group("PLAYER"):
		return
	
	is_player_in_area = false
	prompt.hide()
