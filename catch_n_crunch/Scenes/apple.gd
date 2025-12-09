
extends Area2D

@export var fall_speed = 400

signal caught

func _physics_process(delta):
	position.y += fall_speed * delta

	# If apple goes off-screen → free it
	if position.y > get_viewport_rect().size.y + 20:
		queue_free()
