class_name DialogBox
extends ColorRect


signal dialog_done

var current_text: String = ""
var queue: Array[String] = []

@onready var label: Label = $MarginContainer/Label


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		next()


func queue_text(text: String):
	queue.append(text)


func set_text(text: String):
	current_text = text
	label.text = current_text


func clear():
	current_text = ""
	label.text = current_text


func next():
	if queue:
		set_text(queue.pop_front())
	else:
		dialog_done.emit()
