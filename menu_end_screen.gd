extends CanvasLayer

func _on_quit_button_button_down() -> void:
	Global._on_game_quit()

func _on_restart_button_button_down() -> void:
	#Global._on_game_restart()
	Global._on_game_quit()
	queue_free()
