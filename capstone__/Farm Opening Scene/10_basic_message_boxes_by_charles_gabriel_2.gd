extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()  # Start the timer when the node is ready

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()  # Remove the node when the timer is done
