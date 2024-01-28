extends CharacterBody2D

@export var speed = 125
@onready var animator_node = $PlayerAnimation
@onready var last_direction = "down"

func _physics_process(_delta):
	get_input()
	move_and_slide()

func get_direction():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction == Vector2.LEFT:
		return "left"
	elif input_direction == Vector2.RIGHT:
		return "right"
	
	if input_direction == Vector2.UP:
		return "up"
	elif input_direction == Vector2.DOWN:
		return "down"
	
	if input_direction.y > 0:
		return "down"
	elif input_direction.y < 0:
		return "up"
	else:
		return ""

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	var direction = get_direction() if get_direction() != "" else last_direction
	if velocity == Vector2.ZERO:
		animator_node.play_animation("idle", direction)
	else:
		animator_node.play_animation("walk", direction)
	last_direction = direction
