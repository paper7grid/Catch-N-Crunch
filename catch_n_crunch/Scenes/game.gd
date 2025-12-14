extends Node
var caught_count: int = 0
var apple_scene: PackedScene
var score: int = 0
var score_label: Label
var game_over_label: Label
var game_over: bool = false

func _process(_delta):
	#This to check if restart game
	if game_over and Input.is_action_just_pressed("ui_accept"):  # Spacebar
		restart_game()

func _ready() -> void:
	apple_scene = load("res://Scenes/apple.tscn")
	
	$appletimer.timeout.connect(spawn_apple)
	score_label = $Score
	game_over_label = $GameOver
	game_over_label.visible = false
	update_score()

func spawn_apple():
	if game_over:
		return
	
	var apple = apple_scene.instantiate()
	
	
	
	apple.caught.connect(apple_caught)
	apple.missed.connect(apple_missed)
	
	add_child(apple)
	
	var screen_width = get_viewport().size.x
	apple.position = Vector2(randf_range(50, screen_width - 50), -20)

func apple_caught() -> void:
	print("GAME: Caught signal received! Score:", score, "→", score + 1)
	score += 1
	update_score()
	
func apple_missed() -> void:
	print("GAME: Missed signal received! GAME OVER")
	game_over = true
	$appletimer.stop()
	show_game_over()

func update_score():
	score_label.text = "Score: " + str(score)

func show_game_over():
	game_over_label.visible = true
	score_label.text = "Final Score: " + str(score) + "\nPress SPACE to Restart"

func restart_game():
	for apple in get_tree().get_nodes_in_group("apple"):
		apple.queue_free()
	score = 0
	game_over = false
	update_score()
	
