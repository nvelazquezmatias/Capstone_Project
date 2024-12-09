extends Area2D

@export var toxic_name: String = "ToxicWaste"  # Name of the toxic waste
@export var fall_speed: float = 250  # Speed at which the toxic waste falls

signal toxic_eaten()  # Signal when the toxic waste is eaten

func _on_ToxicWaste_body_entered(body):
	if body.is_in_group("alien"):  
		emit_signal("toxic_eaten")  
		queue_free()  # Remove the toxic waste from the scene

func _process(delta):
	position.y += fall_speed * delta  # Make the toxic waste fall down

	if position.y > 600:  
		queue_free()
