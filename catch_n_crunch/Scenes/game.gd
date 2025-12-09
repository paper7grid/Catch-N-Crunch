extends Node
var caught_count: int = 0
@export var apple_scene: PackedScene
var score: int = 0
var score_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$appletimer.timeout.connect(spawn_apple)
	score_label = $Score

func spawn_apple():
	var apple = apple_scene.instantiate()
	add_child(apple)
	
	
	var screen_width = get_viewport().size.x
	apple.position = Vector2(randi() % screen_width, -20)
#func apple_caught():
	#print("Caught!")  # can add score++
	
func apple_caught(apple: Node2D) -> void:
	score += 1
	update_score()

func update_score():
	score_label.text = "Score: " + str(score)
	
