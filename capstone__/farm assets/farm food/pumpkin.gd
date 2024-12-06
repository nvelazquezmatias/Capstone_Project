extends Area2D

@export var fall_speed: float = 250  # Speed at which the pumpkin falls
@export var pumpkin_sprite: Texture 
@export var pumpkin_name: String = "Pumpkin"  # Name of the food item (ensure this is exported)

# Signal to notify when the pumpkin is eaten
signal pumpkin_eaten

func _on_Pumpkin_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		queue_free()  # Destroy the pumpkin
		emit_signal("pumpkin_eaten", pumpkin_name)  # Emit signal when the pumpkin is eaten

# Called every frame
func _process(delta):
	position.y += fall_speed * delta  # Make the pumpkin fall down

	if position.y > 600:  
		queue_free()
