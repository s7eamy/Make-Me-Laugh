extends Node2D

@export var step_no = 0
var seconds_passed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.is_action_just_pressed("right")
	if input:
		step_no += 1
		print(step_no)
		do_step(step_no)

func do_step(step_no):
	match step_no:
		1:
			get_node("Path2D/PathFollow2D/PlayerAnimation").play_animation("walk", "down")
			get_node("Path2D/PathFollow2D").set_speed(10)
		
		2:
			get_node("Step 2/Sprite2D").show()
			get_node("Path2D/PathFollow2D/PlayerAnimation").play_animation("idle", "down")
		
		3:
			var children = get_node("Step 3").get_children()
			for child in children:
				child.show()
				
		4:
			get_node("Step 4/Sprite2D15").show()
		
		5: 
			var children = get_node("Step 5").get_children()
			for child in children:
				child.show()
				
		6: 
			get_node("Step 2/Sprite2D").hide()
			get_node("Path2D/PathFollow2D/Sprite2D3").show()
			var children = get_node("Step 6").get_children()
			for child in children:
				child.show()
		
		7:
			get_node("Path2D/PathFollow2D").set_speed(-10)
			get_node("Path2D/PathFollow2D/PlayerAnimation").play_animation("walk", "up")
			
		8:
			get_node("Path2D/PathFollow2D/Sprite2D3").hide()
			get_node("Path2D/PathFollow2D/PlayerAnimation").play_animation("idle", "up")
			get_node("Step 8/Sprite2D4").show()
		_:
			pass
