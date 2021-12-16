extends AnimatedSprite

var speed = 50
var path : = PoolVector2Array()

func _process(delta):
	var distance_to_walk = speed * delta

	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			position = path[0]
			path.remove(0)
		distance_to_walk -= distance_to_next_point
