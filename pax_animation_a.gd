extends Node2D

@onready var animations = get_children()
@export var direction = "down"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for animation in animations:
		animation.play("Idle" + direction.capitalize())
		
func _process(delta):
	var ani = "Idle" + direction.capitalize()
	for animation in animations:
		if animation.animation != ani:
			animation.play(ani)
			
func play_animation(action, direction):
	var animation = action.capitalize() + direction.capitalize()
	for anim_node in animations:
		if anim_node.animation.begins_with("Attack") && anim_node.is_playing():
			break;
		if anim_node.name == "Sword" && action != "attack":
			anim_node.visible = false
			continue
		elif anim_node.name == "Sword":
			anim_node.visible = true
		if anim_node.animation != animation:
			anim_node.play(animation)
