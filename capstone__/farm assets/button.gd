extends Button

@onready var popup = $"../Panel"

func _on_pressed() -> void:
	if popup:
		print("Popup found, showing it.")
		popup.show()  # Make the popup visible
	else:
		print("Popup is null. Check the path.")
