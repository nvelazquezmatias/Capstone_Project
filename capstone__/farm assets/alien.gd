extends Area2D

var speed = 200
var velocity = Vector2()

func _ready():
	# Add the alien to the "alien" group so the carrot can identify it
	add_to_group("alien")

func _process(delta):
	velocity = Vector2()  # Reset velocity each frame

	if Input.is_action_pressed("ui_right"):
		position.x = position.x + speed
	if Input.is_action_pressed("ui_left"):
		position.x -= speed

	if Input.is_action_pressed("ui_up"):
		position.y -= speed
	if Input.is_action_pressed("ui_down"):
		position.y += speed

	# Normalize the velocity to avoid diagonal speed increase
	velocity = velocity.normalized() * speed

	# Update the position manually since Area2D doesn't have built-in movement methods like KinematicBody2D
	position += velocity * delta
