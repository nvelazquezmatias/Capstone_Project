extends Node2D

@export var food_scene_dict: Dictionary  
@export var spawn_rate: float = 2.0      
@export var alien: Node2D                
@export var progress_bar: ProgressBar     

var spawn_timer: Timer                   
var score: int = 0                     

func _ready():
	spawn_timer = Timer.new()
	add_child(spawn_timer)  

	spawn_timer.wait_time = spawn_rate  # Set the time interval for food spawning
	spawn_timer.autostart = true  # Start the timer immediately
	spawn_timer.connect("timeout", _on_SpawnTimer_timeout)

	food_scene_dict = {
		"Carrot": preload("res://farm assets/farm food/carrot.tscn"),
		"Pumpkin": preload("res://farm assets/farm food/pumpkin.tscn"),
		"Tomato": preload("res://farm assets/farm food/tomato.tscn"),
		"Leek": preload("res://farm assets/farm food/leek.tscn"),
		"Cauliflower": preload("res://farm assets/farm food/cauliflower.tscn"),
		"Eggplant": preload("res://farm assets/farm food/eggplant.tscn"),
		"Corn": preload("res://farm assets/farm food/corn.tscn")
	}

func _process(delta):
	# Update progress bar value over time (you can use this for any kind of progress)
	if progress_bar:
		progress_bar.value += delta * 10  # Increase progress by 10 per second, adjust as needed

		if progress_bar.value >= progress_bar.max_value:
			progress_bar.value = 0  # Reset progress bar after it reaches max value

func _on_SpawnTimer_timeout():
	# Choose a random food type from the dictionary
	var food_type = food_scene_dict.keys()[randi() % food_scene_dict.size()]  # Randomly pick a food
	var food_scene = food_scene_dict[food_type]  # Get the scene for the selected food
	var food = food_scene.instantiate()  # Create a new instance of the food

	var random_x = randf_range(0, get_viewport().size.x)  # Random X position
	food.position = Vector2(random_x, -food.texture.get_height())  # Spawn above the screen
	add_child(food) 

	food.connect("food_eaten", "_on_FoodEaten")

func _on_FoodEaten(food_name: String):
	score += 1
	print(food_name + " eaten! Score: " + str(score))

	# Optionally, reset progress bar or perform another action
	if progress_bar:
		progress_bar.value = 0  # Reset progress bar when food is eaten (or do something else)
