extends Node2D

@onready var animation = $AnimatedSprite2D

# if pax is moving, these variables are needed to set viewcone and animation correctly
var path
var last_position
var direction = Vector2(0.0, 0.0)

func _ready():
	if get_parent().name == "PathFollow2D":
		path = get_parent()
		last_position = position

func _on_attacked() -> void:
	print("Participant " + name + " was attacked!")
	queue_free()

func _process(delta):
	if get_parent().name == "PathFollow2D":
		animation.play("walk")
		# change animation direction based on movement direction
		direction = position - last_position
		print(direction)
		direction.x = -1 if direction.x - 0.2 < 0  else 1
		direction.y = -1 if direction.y - 0.2 < 0 else 1
		animation.flip_h = direction.x == 1
		last_position = position
		# change viewcone direction based on last
		var rot = 0
		if direction == Vector2(1, -1):
			rot = PI
		elif direction == Vector2(-1, 1):
			rot = 3*PI/2
		elif direction == Vector2(-1, -1):
			rot = PI/2
		$ViewCone.rotation = rot
	else:
		animation.play("stand")

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
