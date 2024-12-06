extends Area2D

@export var fall_speed: float = 250  # Speed at which the carrot falls
@export var carrot_sprite: Texture 
@export var carrot_name: String = "Carrot"

signal carrot_eaten

# Called when the carrot enters the collision area with another object
func _on_Carrot_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		queue_free()  # carrot dissapear
		emit_signal("carrot_eaten") 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta
	
	# If the carrot falls below the screen, destroy it (optional)
	if position.y > 600:  
		queue_free()
