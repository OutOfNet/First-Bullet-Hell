extends Label

var player

func _process(_delta):
	set_text(str("velocity : ", get_node("../../KinematicBody2D").get("velocity")))
