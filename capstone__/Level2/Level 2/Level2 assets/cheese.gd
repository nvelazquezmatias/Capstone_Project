extends Area2D
@export var speed: float = 100.0  # Falling speed of the food

# Called when the food is added to the scene
func _ready() -> void:
	set_process(true)

# Called every frame
func _process(delta: float) -> void:
	# Move the food downwards
	position.y += speed * delta
	
	# Check if the food reaches the bottom of the screen
	if position.y > get_viewport_rect().size.y:
		var main_game = get_tree().root.get_node("Main")
		#if main_game:  # Check if main node is set
			#main_game.lose_life()  # Call lose_life when the food goes off-screen
		queue_free()   # Remove food from the scene
