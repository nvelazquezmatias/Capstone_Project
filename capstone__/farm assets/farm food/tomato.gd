extends Area2D

@export var fall_speed: float = 250  # Speed at which the carrot falls
@export var tomato_sprite: Texture 
@export var tomato_name: String = "Tomato"

signal food_eaten(food_name: String)

func _on_Tomato_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		emit_signal("food_eaten", tomato_name)  # Emit the "food_eaten" signal with the carrot's name
		queue_free() 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta  # Make the carrot fall down
	
	if position.y > 600:  
		queue_free()
