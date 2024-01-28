extends Label

@onready var time = 0.0

func _process(delta):
	time += delta
	text = "%.02f" % time

func get_time():
	return time
