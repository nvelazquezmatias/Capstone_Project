extends Area2D

@export var fall_speed: float = 250  # Speed at which the carrot falls
@export var leek_sprite: Texture 
@export var leek_name: String = "Leek"

signal food_eaten(food_name: String)

# Called when the leek enters the collision area with another object
func _on_Leek_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		emit_signal("food_eaten", leek_name)  # Emit the "food_eaten" signal with the carrot's name
		queue_free() 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta  # Make the carrot fall down
	
	if position.y > 600:  
		queue_free()
