extends Node2D

@export var food_scene_dict: Dictionary
@export var spawn_rate: float = 2.0
@export var progress_bar: ProgressBar

var spawn_timer: Timer
var score: int = 0
var health: int = 100
var health_decrease_rate: int = 5

signal food_eaten(food_name: String)

func _ready():

	# Initialize food dictionary
	food_scene_dict = {
		"Carrot": preload("res://farm assets/farm food/carrot.tscn"),
		"Pumpkin": preload("res://farm assets/farm food/pumpkin.tscn"),
		"Tomato": preload("res://farm assets/farm food/tomato.tscn"),
		"Leek": preload("res://farm assets/farm food/leek.tscn"),
		"Cauliflower": preload("res://farm assets/farm food/cauliflower.tscn"),
		"Eggplant": preload("res://farm assets/farm food/eggplant.tscn"),
		"Corn": preload("res://farm assets/farm food/corn.tscn"),
		"Toxic": preload("res://farm assets/farm food/toxicwaste.tscn")
	}

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

func _on_timer_timeout() -> void:
	$Message.hide()


func _on_spawntimer_timeout() -> void:
	print("spawnvegetables")
	# Choose a random food type
	var food_type = food_scene_dict.keys()[randi() % food_scene_dict.size()]
	var food_scene = food_scene_dict[food_type]
	var food = food_scene.instantiate()

	# Ensure the spawned food is valid and positioned
	if food is Node2D:
		food.position = Vector2(randf_range(0, get_viewport().get_visible_rect().size.x), -200)
		self.add_child(food)
		#food.connect("food_eaten", self, "_on_FoodEaten")
	else:
		print("Error: Food instance is not a Node2D!")


func _on_alien_foodeaten(value) -> void:
	score += value  
	#pass # Replace with function body.
	$ProgressBar.value= score 
	if score >= $ProgressBar.max_value: 
		get_tree().change_scene_to_file("res://LevelUp/LevelUp.tscn") # Replace with function body.
