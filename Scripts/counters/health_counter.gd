extends Label

var player

func _process(_delta):
	set_text(str("health : ", get_parent().get("health")))
