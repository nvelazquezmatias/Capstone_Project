extends Area2D

@export var fall_speed: float = 100  # Speed at which the carrot falls
@export var corn_sprite: Texture

signal food_eaten(food_name)


# Called when the carrot enters the collision area with another object
func _on_Corn_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		emit_signal("food_eaten", "Corn")  # Emit the "food_eaten" signal with the carrot's name
		queue_free()

# Called every frame
func _process(delta):
	position.y += fall_speed * delta  # Make it fall down
	
	if position.y > 600:
		queue_free()
