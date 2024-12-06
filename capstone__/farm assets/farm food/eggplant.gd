extends Area2D

@export var fall_speed: float = 250  # Speed at which it falls
@export var eggplant_sprite: Texture 
@export var eggplant_name: String = "Eggplant"

signal eggplant_eaten

func _on_Eggplant_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		queue_free()  # carrot dissapear
		emit_signal("eggplant_eaten") 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta
	
	# If falls below the screen, destroy it (optional)
	if position.y > 600:  
		queue_free()
