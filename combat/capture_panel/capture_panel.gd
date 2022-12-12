extends ColorRect


signal captured
signal got_away
signal released

const SUCCESS_RATIO: float = 1.0

@onready var capture_button = $MarginContainer/VBoxContainer/CaptureButton
@onready var release_button = $MarginContainer/VBoxContainer/ReleaseButton

func _on_capture_button_pressed():
	if randf() < SUCCESS_RATIO:
		emit_signal("captured")
	else:
		emit_signal("got_away")


func _on_release_button_pressed():
	emit_signal("released")


func _on_visibility_changed():
	if visible:
		capture_button.visible = not Player.is_party_full()
