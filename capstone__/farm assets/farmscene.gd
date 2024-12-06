extends Node2D

@export var food_scene_dict: Dictionary  
@export var spawn_rate: float = 2.0      
@export var alien: Node2D                
var spawn_timer: Timer                   
var score: int = 0                      

func _ready():

	spawn_timer = Timer.new()
	add_child(spawn_timer)  
	spawn_timer.wait_time = spawn_rate  
	spawn_timer.autostart = true  
	spawn_timer.connect("timeout", self, "_on_SpawnTimer_timeout")


	if alien == null:
		alien = get_node("Alien") 

func _on_SpawnTimer_timeout():

	var food_type = food_scene_dict.keys()[randi() % food_scene_dict.size()]  # Randomly pick a food
	var food_scene = food_scene_dict[food_type]  #
	var food = food_scene.instantiate()  # Create a new instance of the food

	var random_x = randf_range(0, get_viewport().size.x)  
	food.position = Vector2(random_x, -food.texture.get_height())  # Spawn above the screen
	add_child(food)  

	food.connect("food_eaten", self, "_on_FoodEaten")

# Called when a food is eaten by the ali
func _on_FoodEaten(food_name: String):
	
