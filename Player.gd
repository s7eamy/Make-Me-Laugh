extends Node2D

signal game_over_failure(failure_message)

@onready var animator_node = $PlayerBody/PlayerAnimation

var is_attacking = false
var is_activating = false
var attackable_target
var activatable_target
var animation_direction

func _physics_process(_delta):
	animation_direction = $PlayerBody.get_direction() if $PlayerBody.get_direction() != "" else animation_direction
	get_input()
	resolve_targets()
	handle_attack()
	handle_activate()

func play_animation(action: String, direction: String):
	var animation = action.capitalize() + direction.capitalize()
	for anim in animator_node.get_children():
		if action == "attack" && anim.name == "Sword":
			anim.visible = true
			anim.play()
		if anim.animation != animation:
			anim.play(animation)

func get_input():
	is_attacking = Input.is_action_just_pressed("attack")
	is_activating = Input.is_action_just_pressed("activate")

func resolve_targets():
	attackable_target = null
	activatable_target = null
	
	attackable_target = resolve_closest_target_in_area(%AttackArea)
	activatable_target = resolve_closest_target_in_area(%ActivateArea)

func resolve_closest_target_in_area(area):
	if not area:
		return
	
	var bodies = area.get_overlapping_bodies()
	var min_distance = INF
	var target = null

	for body in bodies:
		var distance = position.distance_to(body.global_position)
		if distance < min_distance:
			min_distance = distance
			target = body
	return target

func handle_attack():
	if not is_attacking:
		return
		
	play_animation("attack", animation_direction)
	
	if attackable_target && attackable_target.get_parent() && attackable_target.get_parent().has_method("_on_attacked"):
		if attackable_target.get_parent().has_method("check_being_in_vision"):
			attackable_target.get_parent().check_being_in_vision()
		check_being_in_vision(attackable_target)
		
		attackable_target.get_parent()._on_attacked()

func check_being_in_vision(target):
	var vision_cones = %VisionDetector.get_overlapping_areas()

	# check if others have vision on player, excluding the attacked target
	var target_index = vision_cones.find(target.get_parent().get_node("ViewCone"))
	if target_index != -1:
		vision_cones.remove_at(target_index)
	
	for vision in vision_cones:
		if vision.is_in_group("PaxVision"):
			var failure_message = "Player in vision of: " + vision.get_parent().name
			emit_signal("game_over_failure", failure_message)
			break

func handle_activate():
	if not is_activating:
		return
	
	if activatable_target && activatable_target.get_parent() && activatable_target.get_parent().has_method("_on_activated"):
		activatable_target.get_parent()._on_activated()
