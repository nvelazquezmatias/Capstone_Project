extends Area2D

@export var speed: float = 200  # Movement speed

func _ready():
	pass  

func _process(delta):
	# Get the viewport size
	var viewport_size = get_viewport().get_visible_rect().size
	
	# Get direction based on input
	var direction = Vector2()

	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1

	# Update position
	position += direction.normalized() * speed * delta

	# Clamp the position to the screen bounds
	position.x = clamp(position.x, 0, viewport_size.x)
	position.y = clamp(position.y, 0, viewport_size.y)
