extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Function triggered when the TextureButton is pressed
func _on_texture_button_pressed() -> void:
	# Remove the current node (button)
	queue_free()
	get_tree().change_scene_to_file("res://Level1Reward/newimage.tscn") 

	
	
