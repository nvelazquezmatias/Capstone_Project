extends Area2D

@export var fall_speed: float = 250  # Speed at which the carrot falls
@export var tomato_sprite: Texture 
@export var tomato_name: String = "Tomato"

signal tomato_eaten

func _on_Tomato_body_entered(body):
	if body.is_in_group("alien"):  # Check if the body is the alien
		queue_free()  # dissapear
		emit_signal("tomato_eaten") 

# Called every frame
func _process(delta):
	position.y += fall_speed * delta
	
	if position.y > 600:  
		queue_free()
