extends KinematicBody2D

export var speed = 50
var velocity = Vector2()
var direction = Vector2(0,0)

func get_input(delta):	
	if Input.is_action_pressed('ui_right'):
		direction = Vector2(1, 0)
		rotation_degrees = 180 - 135
	if Input.is_action_pressed('ui_left'):
		direction = Vector2(-1, 0)
		rotation_degrees = 90 + 135
	if Input.is_action_pressed('ui_up'):
		direction = Vector2(0, -1)
		rotation_degrees = 90 - 135
	if Input.is_action_pressed('ui_down'):
		direction = Vector2(0, 1)
		rotation_degrees = -90 - 135
	position += speed * direction * delta

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)
