extends Node2D

@export var collision_shape_path: NodePath
@export var grass_texture: Texture
@export var grass_spacing: Vector2i = Vector2i(25, 25)
@export var grass_scale: int = 3

@onready var collision_shape: CollisionShape2D = get_node(collision_shape_path)


func _draw():
	var area_shape := collision_shape.shape as RectangleShape2D
	assert(area_shape)
	assert(grass_texture)
	assert(grass_spacing.x > 0)
	assert(grass_spacing.y > 0)
	assert(grass_scale > 0)
	
	var area_size: Vector2 = area_shape.size
	var pos: Vector2 = collision_shape.position - area_size / 2.0
	
	for x in range(0, area_size.x, grass_spacing.x):
		for y in range(0, area_size.y, grass_spacing.y):
			draw_set_transform(pos + Vector2(x, y), 45.0, Vector2.ONE * grass_scale)
			draw_texture(grass_texture, Vector2.ZERO)
