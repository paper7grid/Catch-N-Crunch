extends Area2D
@export var fall_speed = 500
signal caught
signal missed 
var is_caught = false

func _ready():
	add_to_group("apple") 

func _physics_process(_delta):
	if is_caught:
		return 
	
	position.y += fall_speed * _delta
	
	# Only trigger "missed" if apple goes off BOTTOM of screen
	var screen_height = get_viewport_rect().size.y
	if position.y > screen_height + 50:
		print("Apple MISSED at y:", position.y, " | Screen height:", screen_height)
		emit_signal("missed")
		queue_free()

func catch_apple():
	if is_caught: 
		return
	is_caught = true
	emit_signal("caught")
	queue_free()
