class_name DialogBox
extends ColorRect


@onready var label: Label = $MarginContainer/Label


func set_text(text: String):
	label.text = text


func clear_text():
	label.text = ""
