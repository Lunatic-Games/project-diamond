extends GridContainer


func _ready():
	update_views()


func _unhandled_input(event):
	if visible and event.is_action_pressed("view_party"):
		hide()
		get_viewport().set_input_as_handled()
		get_tree().paused = false


func _on_visibility_changed():
	if visible:
		update_views()


func update_views():
	var index = 0
	for view in get_children():
		if index >= Player.party.size():
			view.clear()
		else:
			view.view_fighter(Player.party[index])
		index += 1
