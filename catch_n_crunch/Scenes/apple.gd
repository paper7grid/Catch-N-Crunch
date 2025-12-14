
extends Area2D

@export var fall_speed = 400

signal caught
signal missed 

func _physics_process(delta):
	position.y += fall_speed * delta

	# If apple goes off-screen → free it
	
	if position.y > get_viewport_rect().size.y + 20:
		emit_signal("missed")  # Emit the missed signal
		queue_free()

func catch_apple():
	emit_signal("caught", self)
	queue_free() 
