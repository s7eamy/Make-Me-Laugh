extends Node2D

var animations = get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for animation in animations:
		animation.play()
