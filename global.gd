extends Node

func _on_game_start():
	handle_game_start()

func _on_game_over_failure(failure_message):
	handle_game_end("failure", failure_message)

func _on_game_over_success(success_message):
	handle_game_end("success", success_message)

func handle_game_start():
	Player.set_process(false)

func handle_game_end(state: String, failure_message=null):
	print(failure_message)
	get_tree().paused = true
	
# TODO: highscore
# TODO: detect all killed npcs
