extends Node2D

@onready var animation = $AnimatedSprite2D

func _on_attacked() -> void:
	print("Participant " + name + " was attacked!")
	queue_free()
	
func _process(delta):
	if get_parent().name == "PathFollow2D":
		animation.play("walk")
	else:
		animation.play("stand")
