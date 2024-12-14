extends TextureButton

@onready var popup = $"../Panel"  # Reference to the Panel node (adjust the path if needed)

func _ready():
	popup.set_visible(false)  # Hide the panel initially when the scene starts

func _on_pressed() -> void:
	if popup.is_visible():
		popup.set_visible(false)  # If visible, hide it
	else:
		popup.set_visible(true)  # If not visible, show it
