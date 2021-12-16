extends KinematicBody2D

var speed : = 40
var velocity = Vector2()
var direction = Vector2(0,0)
var path = []

onready var character = $AnimatedSprite

func _ready():
	set_process(false)

func _unhandled_input(event):
	if not event.is_action_pressed("ui_accept"):
		return
	_update_navigation_path(Vector2(32,60), Vector2(982,538))

func move_along_path(distance):
	var start_point : = position
	for _i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	position += speed * direction * distance

func _physics_process(delta):
	var move_distance = speed * delta
	move_along_path(move_distance)
	velocity = move_and_slide(velocity)

func _update_navigation_path(start_position, end_position):
	var path = get_my_simple_path(start_position, end_position)
	path.remove(0)
	set_process(true)
#	print(path)

func get_my_simple_path(start_position, end_position):
#	print(start_position)
#	print(end_position)
	return [start_position,Vector2(32,124),Vector2(66,124),
		Vector2(66,60),Vector2(110,60),end_position]





