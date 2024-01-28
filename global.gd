extends Node

var player
var end_screen_scene
var stopwatch
var game_over_state = false

#func _ready():

func _on_game_start():
	handle_game_start()

func _on_game_restart():
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_file("res://Main.tscn")
	handle_game_start()

func _on_game_quit():
	get_tree().quit(0)

func _on_game_over_failure(failure_message):
	if game_over_state:
		return
	
	game_over_state = true
	handle_game_end("failure", failure_message)

func _on_game_over_success():
	handle_game_end("success")

func handle_game_start():
	player = get_node("/root/Main/Player")
	end_screen_scene = load("res://menu_end_screen.tscn")
	stopwatch = player.get_node("PlayerBody/Camera2D/HUD/Stopwatch")

	get_tree().paused = false
	player.set_process(false)

func handle_game_end(state: String, failure_message=null):
	get_tree().paused = true
	
	var end_screen = end_screen_scene.instantiate()
	get_tree().get_root().add_child(end_screen)

	if state == "failure":
		if failure_message:
			end_screen.get_node("GameOverReasonLabel").text = failure_message
	elif state == "success":
		var time = stopwatch.get_time()
		var time_str = "%.2f" % time
		end_screen.get_node("GameOverReasonLabel").text = "Congratulations, you killed everyone in " + time_str + " seconds"
		

func get_pax_count():
	var count = get_tree().get_nodes_in_group("Paxs").size()
	if count == 0:
		_on_game_over_success()

	return count
