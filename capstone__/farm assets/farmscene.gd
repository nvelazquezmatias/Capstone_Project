@export var food_scene_dict: Dictionary  
@export var spawn_rate: float = 2.0      
@export var alien: Node2D                
@export var health_bar: ProgressBar     

var spawn_timer: Timer                   
var score: int = 0                     
var health: int = 100                 
var health_decrease_rate: int = 5        

func _ready():
	spawn_timer = Timer.new()
	add_child(spawn_timer)  
	spawn_timer.wait_time = spawn_rate  # Set the time interval for food spawning
	spawn_timer.autostart = true  # Start the timer immediately
	spawn_timer.connect("timeout", self, "_on_SpawnTimer_timeout")
	
	if alien == null:
		alien = get_node("Node2D") 

	if health_bar == null:
		health_bar = get_node("ProgressBar") 

	health_bar.max_value = 100  # Set max health value
	health_bar.value = health   

	food_scene_dict = {
		"Carrot": preload("res://farm assets/farm food/carrot.tscn"),
		"Pumpkin": preload("res://farm assets/farm food/pumpkin.tscn"),
		"Tomato": preload("res://farm assets/farm food/tomato.tscn"),
		"Leek": preload("res://farm assets/farm food/leek.tscn"),
		"Cauliflower": preload("res://farm assets/farm food/cauliflower.tscn"),
		"Eggplant": preload("res://farm assets/farm food/eggplant.tscn"),
		"Corn": preload("res://farm assets/farm food/corn.tscn")
	}
		

signal food_eaten(food_name: String)

func _on_AlienCollision(body):
	if body.is_in_group("alien"):  # If the alien eats the food
		emit_signal("food_eaten", "Carrot")  # Adjust the food name as needed
		queue_free()  # Remove the food
		
func _on_SpawnTimer_timeout():
	# Choose a random food type from the dictionary
	var food_type = food_scene_dict.keys()[randi() % food_scene_dict.size()]  # Randomly pick a food
	var food_scene = food_scene_dict[food_type]  # Get the scene for the selected food
	var food = food_scene.instantiate()  # Create a new instance of the food

	var random_x = randf_range(0, get_viewport().size.x)  # Random X position
	food.position = Vector2(random_x, -food.texture.get_height())  # Spawn above the screen
	add_child(food) 

	food.connect("food_eaten", self, "_on_FoodEaten")

func _on_FoodEaten(food_name: String):
	health -= health_decrease_rate
	if health < 0:
		health = 0  
	
	health_bar.value = health

	score += 1
	print(food_name + " eaten! Score: " + str(score))

	if health == 0:
		game_over()
