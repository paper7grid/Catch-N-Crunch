extends CharacterBody2D
@export var speed: float = 400.0
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
