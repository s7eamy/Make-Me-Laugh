extends PathFollow2D

var speed = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio == 1 || progress_ratio == 0:
		speed = -speed
