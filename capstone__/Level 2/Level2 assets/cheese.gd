extends Area2D

@export var speed: float = 100.0  # Falling speed of the food

func _ready() -> void:
	set_process(true)

# Called every frame
func _process(delta: float) -> void:
	# Move the food downwards
	position.y += speed * delta
	
	# Check if the food reaches the bottom of the screen
	if position.y > get_viewport_rect().size.y:
		var main_game = get_tree().root.get_node("Main")
		if main_game:  # Check if main node is set
			main_game.lose_life()  # Call lose_life when the food goes off-screen
		queue_free()  # Remove food from the scene

# Function to handle collisions with the alien
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("alien"):
		get_tree().current_scene.update_score(1)  # Increase score when food is eaten
		emit_signal("food_eaten", "Food")  # Signal that food was eaten
		queue_free()  # Remove food from the scene