extends ColorRect


signal captured
signal got_away
signal released

const SUCCESS_RATIO: float = 1.0

@onready var capture_button: Button = $MarginContainer/VBoxContainer/CaptureButton
@onready var release_button: Button = $MarginContainer/VBoxContainer/ReleaseButton


func _on_capture_button_pressed() -> void:
	if randf() < SUCCESS_RATIO:
		emit_signal("captured")
	else:
		emit_signal("got_away")


func _on_release_button_pressed() -> void:
	emit_signal("released")


func _on_visibility_changed() -> void:
	if visible:
		capture_button.visible = not Player.party.is_full()
