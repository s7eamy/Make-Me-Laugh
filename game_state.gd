extends Node

func _on_game_over_failure(failure_message):
	handle_game_over("failure", failure_message)

func _on_game_over_success():
	handle_game_over("success")

func handle_game_over(state, failure_message=null):
	print(failure_message)
	get_tree().paused = true
	# TODO: call game_over_UI, show state (victory or loss), show buttons for restarting or quiting the game
