extends Node2D

@export var food_scene_dict: Dictionary  # Dictionary for all food scenes (food type -> scene)
@export var spawn_rate: float = 2.0      # How often a new food spawns (in seconds)
@export var alien: Node2D                # Reference to the alien node
@export var health_bar: ProgressBar     # Reference to the ProgressBar node (health bar)

var spawn_timer: Timer                   # Timer to control spawn rate
var score: int = 0                       # Score for eating food
var health: int = 100                    # Starting health (max value)
var health_decrease_rate: int = 5        # Amount health decreases when food is eaten
var health_increase_rate: int = 10       # Amount health increases when food is eaten

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a timer to spawn food periodically
	spawn_timer = Timer.new()
	add_child(spawn_timer)  # Add the timer to the scene
	spawn_timer.wait_time = spawn_rate  # Set the time interval for food spawning
	spawn_timer.autostart = true  # Start the timer immediately
	spawn_timer.one_shot = false  # Ensure the timer repeats
	spawn_timer.connect("timeout", Callable(self, "_on_SpawnTimer_timeout"))
	
	# Ensure the alien is in the scene
	if alien == null:
		alien = get_node("Node2D")  # Adjust this path if necessary

	# Ensure the health bar is linked in the Inspector
	if health_bar == null:
		health_bar = get_node("ProgressBar")  # Adjust the path to the ProgressBar if necessary

	# Initialize the health bar
	health_bar.max_value = 100  # Set max health value
	health_bar.value = health   # Set initial health value

	# Ensure all food scenes (including toxic waste) are linked in the Inspector
	food_scene_dict = {
		"Carrot": preload("res://farm assets/farm food/carrot.tscn"),
		"Pumpkin": preload("res://farm assets/farm food/pumpkin.tscn"),
		"Tomato": preload("res://farm assets/farm food/tomato.tscn"),
		"Leek": preload("res://farm assets/farm food/leek.tscn"),
		"Cauliflower": preload("res://farm assets/farm food/cauliflower.tscn"),
		"Eggplant": preload("res://farm assets/farm food/eggplant.tscn"),
		"Corn": preload("res://farm assets/farm food/corn.tscn"),
		"ToxicWaste": preload("res://toxicwaste.tscn")  # Add Toxic Waste
	}

# Called every time the spawn timer times out
func _on_SpawnTimer_timeout():
	print("Spawn timer triggered!")  # Debug message to check if timer triggers
	# Choose a random food type from the dictionary (including Toxic Waste)
	var food_type = food_scene_dict.keys()[randi() % food_scene_dict.size()]  # Randomly pick a food or toxic waste
	var food_scene = food_scene_dict[food_type]  # Get the scene for the selected food
	var food = food_scene.instantiate()  # Create a new instance of the food

	# Spawn the food at a random position on top of the screen
	var random_x = randf_range(0, get_viewport().size.x)  # Random X position
	food.position = Vector2(random_x, -food.texture.get_height())  # Spawn above the screen
	add_child(food)

	# Connect the signal from the food to handle when it is eaten
	if food.has_signal("food_eaten"):
		food.connect("food_eaten", self, "_on_FoodEaten")
	if food.has_signal("toxic_eaten"):
		food.connect("toxic_eaten", self, "_on_ToxicEaten")

# Called when a food is eaten by the alien
func _on_FoodEaten(food_name: String):
	# Increase the score when food is eaten (optional)
	score += 1
	print(food_name + " eaten! Score: " + str(score))

	# Optionally, do more actions when health is reduced (e.g., game over check)
	# For food items, we can increase the health or do nothing:
	health += health_increase_rate
	if health > 100:
		health = 100  # Ensure health doesn't exceed 100
	
	# Update the health bar value
	health_bar.value = health

# Called when toxic waste is eaten
func _on_ToxicEaten():
	# Decrease health when toxic waste is eaten
	health -= 20  # Adjust this value for the severity of the effect
	if health < 0:
		health = 0  # Prevent health from going below zero

	# Update the health bar value
	health_bar.value = health

	print("Toxic waste eaten! Health: " + str(health))

	# Optionally, check for game over
	if health == 0:
		game_over()

# Game over logic (if health reaches zero)
func game_over():
	print("Game Over!")
	# You can add more game over logic here, such as pausing the game, showing a screen, etc.
	get_tree().paused = true  # Pause the game
