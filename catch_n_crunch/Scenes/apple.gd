extends Area2D

@export var fall_speed = 500

signal caught

func _physics_process(delta):
	position.y += fall_speed * delta

	# If apple goes off-screen → free it
	if position.y > get_viewport_rect().size.y + 20:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "basket":
		emit_signal("caught")
		queue_free()
