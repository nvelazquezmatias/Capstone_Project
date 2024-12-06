extends Node2D

@onready var animation_player_1 = $AnimatedSprite2D  # Reference to the first AnimatedSprite2D
@onready var animation_player_2 = $AnimatedSprite2D2 # Reference to the second AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Play both animations at the same time
	animation_player_1.play("AnimatedSprite2D")  # Replace "animation_1" with the actual name of your animation
	animation_player_2.play("AnimatedSprite2D2")  # Replace "animation_2" with the actual name of your animation

# Called when the button is pressed
func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Farm Opening Scene/farm_openingscene.tscn") # Replace with function body.
