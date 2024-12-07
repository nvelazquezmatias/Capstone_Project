extends Area2D

@export var fall_speed: float = 250  # Speed at which the carrot falls
@export var carrot_sprite: Texture 
@export var carrot_name: String = "Carrot"

signal food_eaten(food_name: String)

# Called when the carrot enters the collision area with another object
func _on_Carrot_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		emit_signal("food_eaten", carrot_name)  # Emit the "food_eaten" signal with the carrot's name
		queue_free() 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta  # Make the carrot fall down
	
	if position.y > 600:  
		queue_free()
