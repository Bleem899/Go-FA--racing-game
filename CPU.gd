extends Navigation2D

export(float) var character_speed = 200.0
var path = []

onready var character = $RigidBody2D/AnimatedSprite

func _process(delta):
	var walk_distance = character_speed * delta
	move_along_path(walk_distance)

func _unhandled_input(event):
	if not event.is_action_pressed("mouse_clicked"):
		return
	_update_navigation_path(Vector2(32,57), Vector2(500,250))

func move_along_path(distance):
	var last_point = character.position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points:
			character.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	character.position = last_point
	set_process(false)
	print(character.position)

func _update_navigation_path(start_position, end_position):
	path = get_my_simple_path(start_position, end_position, false)
	path.remove(0)
	set_process(true)
#	print(path)

func get_my_simple_path(start_position, end_position, istrue):
	return [start_position,Vector2(0,64),Vector2(64,64),
		Vector2(64,0),Vector2(128,0),Vector2(128,64),
		Vector2(192,64),Vector2(192,128),Vector2(256,128)
		,Vector2(256,64),Vector2(256,0),Vector2(320,0)
		,Vector2(320,64),Vector2(384,64),Vector2(384,0),
		Vector2(448,0),Vector2(512,0),Vector2(512,64)
		,Vector2(448,64),Vector2(448,128),Vector2(512,128)
		,Vector2(576,128),Vector2(576,192),Vector2(576,256)
		,Vector2(640,256),Vector2(704,256),Vector2(768,256)
		,Vector2(832,256),Vector2(896,256),Vector2(896,320),
		Vector2(896,384),Vector2(896,448),Vector2(960,448),
		Vector2(960,512)]
