extends CanvasLayer

func _on_quit_button_button_down() -> void:
	get_tree().quit(0)

func _on_start_button_button_down() -> void:
	get_parent().get_node("Stopwatch").time = 0.0
	Global.handle_game_start()
	queue_free()
