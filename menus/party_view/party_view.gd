extends GridContainer


func _ready() -> void:
	assert(get_child_count() == Player.party.MAX_SIZE)
	update_views()


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("view_party"):
		hide()
		get_viewport().set_input_as_handled()
		get_tree().paused = false


func _on_visibility_changed() -> void:
	if visible:
		update_views()


func update_views() -> void:
	var index: int = 0
	
	for view in get_children():
		if index >= Player.party.get_size():
			view.clear()
		else:
			view.view_fighter(Player.party.fighters[index])
		index += 1
