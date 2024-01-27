extends Node2D

signal attack

var is_attacking = false
var is_activating = false
var attackable_target
var activatable_target

func _physics_process(_delta):
	get_input()
	#check_being_in_vision()
	resolve_targets()
	handle_attack()
	handle_activate()

func get_input():
	is_attacking = Input.is_action_just_pressed("attack")
	is_activating = Input.is_action_just_pressed("activate")

func check_being_in_vision():
	var areas = %VisionDetector.get_overlapping_areas()
	
	for area in areas:
		if area.is_in_group("PaxVision"):
			print('In vision of: ' + area.name)

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
		#check_being_in_vision()
		attackable_target.get_parent()._on_attacked()

func handle_activate():
	if not is_activating:
		return
	
	if activatable_target && activatable_target.get_parent() && activatable_target.get_parent().has_method("_on_activated"):
		activatable_target.get_parent()._on_activated()
