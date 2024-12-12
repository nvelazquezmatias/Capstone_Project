extends CharacterBody2D
var speed: float = 200  # Movement speed
signal foodeaten

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

	velocity= direction.normalized() * speed 
	move_and_slide()

func _on_timer_timeout() -> void:
	pass # Replace with function body.

func _on_area_2d_area_entered(body: Area2D) -> void:
	if body.is_in_group("toxic"):  # Check if the object is food
		foodeaten.emit(-1)
	else:
	
		body.queue_free()  # Destroy food
		foodeaten.emit(1)
	#get_tree().current_scene.update_score(1) 
