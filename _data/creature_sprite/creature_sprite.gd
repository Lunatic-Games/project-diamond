extends Node2D


@export var idle_animation: Animation

@onready var animation_player := $AnimationPlayer

func _ready():
	animation_player.play()
