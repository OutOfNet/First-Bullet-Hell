extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var fall_acceleration = 750
const jump_force = 350
var velocity = Vector2.ZERO
var direction := Input.get_axis("left_input", "right_input")
var is_mid_air = false
var has_jumped = false
var max_fall_speed = 250

func _input(_event):
	if Input.is_action_pressed("left_input") == true:
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right_input") == true:
		$AnimatedSprite.flip_h = false
	if Input.is_action_just_pressed("jump_input"):
		velocity.y -= jump_force
	elif Input.is_action_just_pressed("down_input"):
		max_fall_speed = 500
	elif Input.is_action_just_released("down_input"):
		max_fall_speed = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction = Input.get_axis("left_input", "right_input")
	print(velocity.y)
	print(velocity.x)
	if velocity.y == 0 && velocity.x == 0:
		$AnimatedSprite.play("idle")
	elif velocity.x != 0 && velocity.y == 0:
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("mid_air")
	if velocity.y < -250:
		velocity.y = -250
	elif velocity.y > max_fall_speed:
		velocity.y = max_fall_speed
	velocity.x = speed * direction
	velocity.y += fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector2.ZERO)
