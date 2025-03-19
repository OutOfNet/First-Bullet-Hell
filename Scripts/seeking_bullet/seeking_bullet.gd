extends RigidBody2D

var player
var player_angle # defines the angle at which the attack has to go to reach the player
var velocity = Vector2.ZERO

func _ready():
	player = get_node("../Player")
	player_angle
	look_at(player.position)

func _physics_process(_delta):
	velocity += Vector2(0.1, 0.25)
	position += velocity
