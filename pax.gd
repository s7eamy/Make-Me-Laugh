extends Node2D

@onready var animator_node = $PaxAnimationA

# if pax is moving, these variables are needed to set viewcone and animation correctly
var path
var last_position
var direction = Vector2(0.0, 0.0)

func _ready():
	if get_parent().name == "PathFollow2D":
		path = get_parent()
		last_position = path.position

func _on_attacked() -> void:
	print("Participant " + name + " was attacked!")
	queue_free()

func play_animation(action: String, direction: String):
	var animation = action.capitalize() + direction.capitalize()
	for child in animator_node.get_children():
		if child.animation != animation:
			child.play(animation)
		

func _process(delta):
	if get_parent().name == "PathFollow2D":
		# change animation direction based on movement direction
		direction = Vector2(0, 0)
		if path.position.x > last_position.x:
			direction.x = 1
			play_animation("walk", "right")
		elif path.position.x < last_position.x:
			direction.x = -1
			play_animation("walk", "left")
		if path.position.y > last_position.y:
			direction.y = 1
			play_animation("walk", "down")
		elif path.position.y < last_position.y:
			direction.y = -1
			play_animation("walk", "up")
		last_position = path.position
		# change viewcone direction based on last
		$ViewCone.rotation = direction.angle()
	else:
		pass

func check_being_in_vision():
	var vision_cones = %VisionDetector.get_overlapping_areas()

	# self ViewCone is overlapping with self VisionDetector, so exclude it 
	var self_index = vision_cones.find($ViewCone)
	if self_index != -1:
		vision_cones.remove_at(self_index)
	
	for vision in vision_cones:
		if vision.is_in_group("PaxVision"):
			print('Pax in vision of: ' + vision.get_parent().name)
			# TODO: invoke gameover
			break
