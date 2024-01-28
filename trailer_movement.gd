extends PathFollow2D

@export var speed = 0

func set_speed(speed_arg):
	speed = speed_arg

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
