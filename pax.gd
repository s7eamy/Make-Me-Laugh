extends Node2D

@onready var animation = $AnimatedSprite2D
@onready var path = get_parent()
@onready var last_position = path.position

func _on_attacked() -> void:
	print("Participant " + name + " was attacked!")
	queue_free()

func _process(delta):
	if get_parent().name == "PathFollow2D":
		animation.play("walk")
	else:
		animation.play("stand")
	
	# change animation direction based on movement direction
	var direction = last_position - path.position
	animation.flip_h = direction.x - 0.2 > 0
	last_position = path.position
