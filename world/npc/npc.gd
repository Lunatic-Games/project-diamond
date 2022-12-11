extends StaticBody2D


var is_player_in_interact_area: bool = false

@onready var interact_prompt := $InteractPrompt


func _ready():
	interact_prompt.hide()


func _input(event):
	if event.is_action_pressed("interact") and is_player_in_interact_area:
		get_tree().change_scene_to_file("res://combat/combat.tscn")


func _on_interact_area_body_entered(body):
	if not body.is_in_group("PLAYER"):
		return
	
	is_player_in_interact_area = true
	interact_prompt.show()


func _on_interact_area_body_exited(body):
	if not body.is_in_group("PLAYER"):
		return
	
	is_player_in_interact_area = false
	interact_prompt.hide()
