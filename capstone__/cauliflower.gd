extends Area2D

@export var fall_speed: float = 250  # Speed at which the carrot falls
@export var cauliflower_sprite: Texture 
@export var cauliflower_name: String = "Cauliflower"

signal cauliflower_eaten

func _on_Cauliflower_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		queue_free()  # dissapear
		emit_signal("cauliflower_eaten") 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta
	
	if position.y > 600:  
		queue_free()
