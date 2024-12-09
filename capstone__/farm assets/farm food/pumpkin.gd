extends Area2D

@export var fall_speed: float = 250  # Speed at which the pumpkin falls
@export var pumpkin_sprite: Texture 
@export var pumpkin_name: String = "Pumpkin"  # Name of the food item (ensure this is exported)

signal food_eaten(food_name: String)

# Called when the pumpkin enters the collision area with another object
func _on_Pumpkin_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		emit_signal("food_eaten", pumpkin_name) 
		queue_free() 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta  # Make the carrot fall down
	
	if position.y > 600:  
		queue_free()
