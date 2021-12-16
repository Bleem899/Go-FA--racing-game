extends KinematicBody2D

export(int) var SPEED: int = 40
var velocity: Vector2 = Vector2.ZERO

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]

func _physics_process(delta):
	if player and levelNavigation:
		generate_path()
		navigate()
	move()

func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
		
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, Vector2(500, 500), false)

func move():
	velocity = move_and_slide(velocity)
	
