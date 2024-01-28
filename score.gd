extends Label

func _process(_delta):
	var score = Global.get_pax_count()
	%ScoreLabel.text = "People left: %d" % (score)
