extends Node2D

@onready var animations = get_children()
@export var direction = "down"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for animation in animations:
		animation.play("idle" + direction.capitalize())
		
func _process(delta):
	var ani = "Idle" + direction.capitalize()
	for animation in animations:
		if animation.animation != ani:
			animation.play(ani)
