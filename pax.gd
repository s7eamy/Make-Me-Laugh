extends Node2D

@onready var animation = $AnimatedSprite2D

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

func _process(delta):
	if get_parent().name == "PathFollow2D":
		animation.play("walk")
		# change animation direction based on movement direction
		direction = Vector2(0, 0)
		if path.position.x > last_position.x:
			direction.x = 1
		elif path.position.x < last_position.x:
			direction.x = -1
		# no clue why these are inverted
		if path.position.y > last_position.y:
			direction.y = 1
		elif path.position.y < last_position.y:
			direction.y = -1
		last_position = path.position
		animation.flip_h = direction.x == -1
		# change viewcone direction based on last
		$ViewCone.rotation = direction.angle()
	else:
		animation.play("stand")
	
