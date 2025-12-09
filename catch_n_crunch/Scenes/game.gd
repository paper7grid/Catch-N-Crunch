extends Node
@export var apple_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$appletimer.timeout.connect(spawn_apple)

func spawn_apple():
	var apple = apple_scene.instantiate()
	add_child(apple)
	
	var screen_width = get_viewport().size.x
	apple.position = Vector2(randi() % screen_width, -20)
	apple.caught.connect(apple_caught)
func apple_caught():
	print("Caught!")  # later change to score++
