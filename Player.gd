extends Node2D

#func _ready():
	#set_process(false)

var is_attacking = false
var is_activating = false
var attackable_target
var activatable_target

func _physics_process(_delta):
	get_input()
	resolve_targets()
	handle_attack()
	handle_activate()

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
			var failure_message = "Player was in vision of: " + vision.get_parent().name
			Global._on_game_over_failure(failure_message)
			break

func handle_activate():
	if not is_activating:
		return
	
	if activatable_target && activatable_target.get_parent() && activatable_target.get_parent().has_method("_on_activated"):
		activatable_target.get_parent()._on_activated()
