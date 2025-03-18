extends KinematicBody2D

export var speed = 300
export var fall_acceleration = 1125
const jump_force = 400
const base_max_fall_speed = 250
const max_health = 100
var health = max_health
var velocity = Vector2.ZERO
var direction := Input.get_axis("left_input", "right_input")
var is_mid_air = false
var has_jumped = false
var max_fall_speed = 375
var is_on_cooldown = false
var damage_cooldown = 1
var attacks_entered = []

func take_damage():
	health -= 10
	is_on_cooldown = true
	print(health)
	get_node("../damage_cooldown").start(damage_cooldown)

func _input(_event):
	if Input.is_action_pressed("left_input") == true:
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right_input") == true:
		$AnimatedSprite.flip_h = false
	if Input.is_action_just_pressed("jump_input"):
		velocity.y -= jump_force
	elif Input.is_action_just_pressed("down_input"):
		max_fall_speed = base_max_fall_speed * 2
	elif Input.is_action_just_released("down_input"):
		max_fall_speed = base_max_fall_speed

func _physics_process(delta):
	direction = Input.get_axis("left_input", "right_input")
	
	# Handles player animations (if else, if else, if else...)
	if (velocity.y <= 0.0001 && velocity.y >= -0.0001) && velocity.x == 0:
		$AnimatedSprite.play("idle")
	elif velocity.x != 0 && (velocity.y <= 0.0001 && velocity.y >= -0.0001):
		$AnimatedSprite.play("run")
	elif velocity.y != 0:
		$AnimatedSprite.play("mid_air")
	if velocity.y < -jump_force:
		velocity.y = -jump_force
	elif velocity.y > max_fall_speed:
		velocity.y = max_fall_speed
	
	# Handles movement
	velocity.x = speed * direction
	velocity.y += fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector2.ZERO)

func _on_hitbox_entered_body(body):
	if body.get_class() == "RigidBody2D" && is_on_cooldown == false:
		attacks_entered.append(body)
		take_damage()

func _on_Timer_timeout():
	if is_on_cooldown == true:
		is_on_cooldown = false
		print("damage is no longer on cooldown")
		if attacks_entered.empty() != true:
			take_damage()


func _on_hitbox_exited_body(body):
	if body.get_class() == "RigidBody2D":
		attacks_entered.erase(body)
