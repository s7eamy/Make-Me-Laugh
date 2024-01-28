extends Node2D

@export var step_no = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.is_action_just_pressed("right")
	if input:
		step_no += 1

func do_step_1():
	pass
	
func do_step_2():
	pass
