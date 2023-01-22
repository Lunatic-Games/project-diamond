class_name NPC
extends StaticBody2D


signal encounter

@export var party: Array[Creature]


func _on_interact_area_interacted_with() -> void:
	emit_signal("encounter")
