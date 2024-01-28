extends CanvasLayer

func _on_quit_button_button_down() -> void:
	get_tree().quit(0)
	

func _on_restart_button_button_down() -> void:
	# do something
	queue_free()
