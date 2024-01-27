extends Node

func handle_game_over(state):
	get_tree().paused = true
	# TODO: call game_over_UI, show state (victory or loss), show buttons for restarting or quiting the game
