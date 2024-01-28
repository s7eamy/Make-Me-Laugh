extends Node2D

@onready var animations = get_children()

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

func _ready():
	play_animation("idle", "down")

func _on_body_animation_finished() -> void:
	play_animation("idle", "down")
