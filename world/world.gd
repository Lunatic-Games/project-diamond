extends Node2D


@onready var party_view = $CanvasLayer/PartyView


func _unhandled_input(event):
	if event.is_action_pressed("view_party") and not party_view.visible:
		party_view.show()
		get_tree().paused = true
		get_viewport().set_input_as_handled()
