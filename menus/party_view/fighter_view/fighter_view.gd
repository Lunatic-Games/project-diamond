extends ColorRect

var fighter_sprite: Node2D = null

@onready var fighter_position: Marker2D = $FighterPosition


func view_fighter(fighter: Fighter) -> void:
	clear()
	
	var sprite: Node2D = fighter.creature_scene.instantiate()
	add_child(sprite)
	sprite.position = fighter_position.position
	fighter_sprite = sprite


func clear() -> void:
	if fighter_sprite:
		fighter_sprite.queue_free()
