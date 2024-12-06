extends Node2D

@export var food_scene_dict: Dictionary  
@export var spawn_rate: float = 2.0      
@export var alien: Node2D                
var spawn_timer: Timer                   
var score: int = 0                       

func _ready():
	spawn_timer = Timer.new()
	add_child(spawn_timer)  # Add the timer to the scene
	spawn_timer.wait_time = spawn_rate  # Set the time interval for food spawning
	spawn_timer.autostart = true  # Start the timer immediately
	spawn_timer.connect("timeout", self, "_on_SpawnTimer_timeout")
	
	if alien == null:
		alien = get_node("Alien")  # Adjust this path if necessary

func _on_SpawnTimer_timeout():
	# Choose a random food type from the dictionary
	var food_type = food_scene_dict.keys()[randi() % food_scene_dict.size()]  # Randomly pick a food
	var food_scene = food_scene_dict[food_type]  # Get the scene for the selected food
	var food = food_scene.instantiate()  # Create a new instance of the food

	# Spawn the food at a random position on top of the screen
	var random_x = randf_range(0, get_viewport().size.x)  # Random X position
	food.position = Vector2(random_x, -food.texture.get_height())  # Spawn above the screen
	add_child(food)  # Add food to the scene

	# Connect the signal from the food to handle when it is eaten
	food.connect("food_eaten", self, "_on_FoodEaten")
	
	func _on_FoodEaten(food_name: String):
	# Increase the score
	#score += 1
	#print(food_name + " eaten! Score: " + str(score))



func _on_timer_timeout() -> void:
	pass # Replace with function body.
