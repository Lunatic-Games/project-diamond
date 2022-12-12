extends ColorRect

var fighter_sprite: Node2D = null

@onready var fighter_position = $FighterPosition


func view_fighter(fighter: Fighter):
	clear()
	
	var sprite = fighter.creature_scene.instantiate()
	add_child(sprite)
	sprite.position = fighter_position.position
	fighter_sprite = sprite


func clear():
	if fighter_sprite:
		fighter_sprite.queue_free()
