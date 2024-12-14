extends Sprite2D

@onready var legend_panel = $"../LegendPanel"  # Adjust path to match your node structure

func _ready():
	if legend_panel:
		legend_panel.visible = false  # Ensure the legend starts hidden
	else:
		print("LegendPanel not found! Check the node path.")

func _on_TextureButton_pressed():
	if legend_panel:
		# Toggle visibility of the legend panel
		legend_panel.visible = not legend_panel.visible
	else:
		print("LegendPanel not found! Check the node path.")
