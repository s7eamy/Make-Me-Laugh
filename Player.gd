extends Node2D

signal attack
var is_attacking = false
var target

func _physics_process(_delta):
	get_input()
	resolve_target()
	handle_attack()

func get_input():
	is_attacking = Input.is_action_just_pressed("attack")

func resolve_target():
	target = null
	var min_distance = INF
	var bodies = %AttackRadius.get_overlapping_bodies()
	
	for body in bodies:
		var distance = position.distance_to(body.global_position)
		if distance < min_distance:
			min_distance = distance
			target = body

func handle_attack():
	if not is_attacking:
		return
	
	if target && target.get_parent() && target.get_parent().has_method("_on_attacked"):
		target.get_parent()._on_attacked()
