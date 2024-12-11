extends Area2D

@export var speed: float = 100.0  # Falling speed of the toxic waste
signal toxic_eaten()  # Signal for when toxic waste is eaten

# Called when the toxic waste is added to the scene
func _ready() -> void:
	set_process(true)

# Called every frame
func _process(delta: float) -> void:
	# Move the toxic waste downwards
	position.y += speed * delta
	
	# Check if the toxic waste reaches the bottom of the screen
	if position.y > get_viewport_rect().size.y:
		var main_game = get_tree().root.get_node("Main")
		if main_game:  # Check if main node is set
			main_game.lose_life()  # Call lose_life when the toxic waste goes off-screen
		queue_free()  # Remove toxic waste from the scene

# Function to handle collisions with the alien (when eaten)
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("alien"):
		get_tree().current_scene.update_score(1)  # Increase score when toxic waste is eaten
		emit_signal("toxic_eaten")  # Emit the toxic_eaten signal
		queue_free()
