extends PathFollow2D

var speed = 25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if abs(progress_ratio - 0.37) < 0.01:
		delta *= 0.1
	progress += speed * delta
