extends CharacterBody2D
@export var speed: float = 900.0
func _physics_process(delta):
	var direction = 0
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1
	velocity.x = direction * speed
	move_and_slide()
	var screen_width = get_viewport().get_visible_rect().size.x
	position.x = clamp(position.x, 30, screen_width - 30)
func _on_basket_area_entered(area: Area2D) -> void:
	if area.is_in_group("apple"):
		area.emit_signal("caught", area)
