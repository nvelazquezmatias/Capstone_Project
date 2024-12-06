extends Area2D

@export var fall_speed: float = 250  # Speed at which the carrot falls
@export var corn_sprite: Texture 
@export var corn_name: String = "Corn"

signal corn_eaten

func _on_Corn_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		queue_free()  # dissapear
		emit_signal("corn_eaten") 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta
	
	if position.y > 600:  
		queue_free()
