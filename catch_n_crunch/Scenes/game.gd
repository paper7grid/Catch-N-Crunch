extends Node
var caught_count: int = 0
@export var apple_scene: PackedScene
var score: int = 0
var score_label: Label
var game_over_label: Label
var game_over: bool = false

func _ready() -> void:
	# DEBUG CHECKS
	print("=== GAME STARTING ===")
	print("apple_scene = ", apple_scene)
	print("apple_scene is null? ", apple_scene == null)
	
	if apple_scene == null:
		print("CRITICAL ERROR: Apple scene not assigned!")
		push_error("Please assign apple.tscn to Apple Scene in the Inspector!")
		return  # Stop here if no apple scene
	
	$appletimer.timeout.connect(spawn_apple)
	score_label = $Score
	game_over_label = $GameOver
	game_over_label.visible = false
	update_score()
	print("=== READY COMPLETE ===")

func spawn_apple():
	print("--- spawn_apple called ---")
	
	if game_over:
		print("Game is over, not spawning")
		return
	
	if apple_scene == null:
		print("ERROR: apple_scene is STILL null in spawn_apple!")
		return
	
	print("About to instantiate apple...")
	var apple = apple_scene.instantiate()
	print("Apple instantiated successfully!")
	
	# Connect signals FIRST!
	apple.caught.connect(apple_caught)
	apple.missed.connect(apple_missed)
	
	add_child(apple)
	
	var screen_width = get_viewport().size.x
	apple.position = Vector2(randi() % int(screen_width), -20)
	print("Apple spawned at position: ", apple.position)

func apple_caught(apple: Node2D) -> void:
	score += 1
	update_score()
	
func apple_missed() -> void:
	game_over = true
	$appletimer.stop()
	show_game_over()

func update_score():
	score_label.text = "Score: " + str(score)

func show_game_over():
	game_over_label.visible = true
	score_label.text = "Final Score: " + str(score)
