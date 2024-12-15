extends Node2D

@export var food_scene_dict: Dictionary
@export var spawn_rate: float = 5.0
@export var progress_bar: ProgressBar

var spawn_timer: Timer
var score: int = 0
var health: int = 100
var health_decrease_rate: int = 5

signal food_eaten(food_name: String)

func _ready():
	
	# Initialize food dictionary
	food_scene_dict = {
		"Drink": preload("res://Level2/Level 2/Level2 assets/drink.tscn"),
		"Tuna": preload("res://Level2/Level 2/Level2 assets/tuna.tscn"),
		"Chips": preload("res://Level2/Level 2/Level2 assets/chips.tscn"),
		"PeanutButter": preload("res://Level2/Level 2/Level2 assets/peanutbutter.tscn"),
		"ToxicWaste": preload("res://Level2/Level 2/Level2 assets/toxicwaste.tscn")
	}
	
	spawn_timer = Timer.new()  # Create a new Timer instance
	spawn_timer.wait_time = spawn_rate  # Start with base spawn rate
	spawn_timer.autostart = true  # Make it auto-start
	spawn_timer.connect("timeout", _on_spawntimer_timeout)  # Connect the timeout signal to spawn food
	add_child(spawn_timer)  # Add the timer to the scene tree

func _on_FoodEaten(food_name: String):
	score += 1
	health -= health_decrease_rate
	if health < 0:
		health = 0

	print(food_name + " eaten! Score: " + str(score))
	if health == 0:
		game_over()

func game_over():
	print("Game Over!" + str(score))


func _on_spawntimer_timeout() -> void:
	print("spawnfood")
	
	# Chance for ToxicWaste to spawn more frequently
	var spawn_chance = randi() % 100  # Random number between 0 and 99

	var food_type = ""
	if spawn_chance < 50:  # 30% chance to spawn ToxicWaste
		food_type = "ToxicWaste"
	else:
		var food_types = ["Drink", "Tuna", "Chips", "PeanutButter"]
		food_type = food_types[randi() % food_types.size()]  # Pick a random food from the list

	# Choose the food scene
	var food_scene = food_scene_dict[food_type]
	var food = food_scene.instantiate()

	# Ensure the spawned food is valid and positioned
	if food is Node2D:
		food.position = Vector2(randf_range(0, get_viewport().get_visible_rect().size.x), -200)
		self.add_child(food)
	else:
		print("Error: Food instance is not a Node2D!")


func _on_alien_foodeaten(value) -> void:
	score += value  
	#pass # Replace with function body.
	$ProgressBar.value= score 
	if score >= $ProgressBar.max_value: 
		get_tree().change_scene_to_file("res://Final Scene/final.tscn") # Replace with function body.
