extends Area2D
var speed: float = 200  # Movement speed

func _ready():
	pass  


func _process(delta):
	var direction = Vector2()  #

	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1

	position += direction.normalized() * speed * delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("food"):  # Check if the object is food
		body.queue_free()  # Destroy food
		# Update score or game state as needed


func _on_timer_timeout() -> void:
	pass # Replace with function body.
