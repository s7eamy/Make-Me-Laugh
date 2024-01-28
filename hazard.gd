extends Node2D

func _on_activated():
	var bodies = $AttackRadius.get_overlapping_bodies()
	for body in bodies:
		if body && body.get_parent() && body.get_parent().has_method("_on_attacked"):
			body.get_parent()._on_attacked()
	
	for anim_node in $LightningAnimation.get_children():
		anim_node.visible = true
		anim_node.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	for anim_node in $LightningAnimation.get_children():
		anim_node.visible = false
