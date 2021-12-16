extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

var cell_walls = {Vector2(0, -1): N, Vector2(1, 0): E,
					Vector2(0, 1): S, Vector2(-1, 0): W}

onready var screen_size = get_viewport().size

var tile_size = 64
var width = 1024/64
var height = 600/64

var erase_fraction = 0.2

onready var Map = $TileMap
var PlayerScore = 0
var CPUScore = 0

func _ready():
#	randomize()
	tile_size = Map.cell_size
#	$CPU.map = Map
#	$CPU.map_pos = Vector2(0, 0)
#	$CPU.position = Map.map_to_world($CPU.map_pos) + Vector2(32, 32)
	make_maze()
	erase_walls()
	Map.update_dirty_quadrants()

func check_neighbors(cell, unvisited):
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list

func make_maze():
	var unvisited = []
	var stack = []
	Map.clear()
	for x in range(width):
		for y in range(height):
			unvisited.append(Vector2(x, y))
			Map.set_cellv(Vector2(x, y), N|E|S|W)
	var current = Vector2(0, 0)
	unvisited.erase(current)
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			var dir = next - current
			var current_walls = Map.get_cellv(current) - cell_walls[dir]
			var next_walls = Map.get_cellv(next) - cell_walls[-dir]
			Map.set_cellv(current, current_walls)
			Map.set_cellv(next, next_walls)
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
#		yield(get_tree(), "idle_frame")

func erase_walls():
	for _i in range(int(width * height * erase_fraction)):
		var x = int(rand_range(1, width-1))
		var y = int(rand_range(1, height-1))
		var cell = Vector2(x, y)
		var neighbor = cell_walls.keys()[randi() % cell_walls.size()]
		if Map.get_cellv(cell) & cell_walls[neighbor]:
			var walls = Map.get_cellv(cell) - cell_walls[neighbor]
			var n_walls = Map.get_cellv(cell + neighbor) - cell_walls[-neighbor]
			Map.set_cellv(cell, walls)
			Map.set_cellv(cell+neighbor, n_walls)

func player_wins_round():
	PlayerScore += 1
	$HUD.update_score(PlayerScore, CPUScore)
	$HUD.show_round_over(0)
	$Music.stop()

func cpu_wins_round():
	CPUScore += 1
	$HUD.update_score(PlayerScore, CPUScore)
	$HUD.show_round_over(1)
	$Music.stop()

func new_round():
#	_ready()
	$Player.position = ($StartPosition.position)
	$Player.direction = Vector2(0,0)
	$Player.show()
	$CPU.position = ($StartPosition.position)
	$CPU.show()
#	$TestCPU.position = ($StartPosition.position)
	$HUD.update_score(PlayerScore, CPUScore)
	$HUD.show_message("Get Ready")
	$Music.play()
	$Goal.start()

func round_over():
	if PlayerScore == 5 || CPUScore == 5 :
		game_over()
	else:
		$HUD.show_round_over()
	$Music.stop()

func new_game():
	$Player.position = ($StartPosition.position)
	$CPU.position = ($StartPosition.position)
#	$TestCPU.position = ($StartPosition.position)
	$HUD.show_message("Get Ready")
	$Music.play()
	$Goal.start()
#	$CPU._unhandled_input(_on_StartTimer_timeout())

func game_over():
	$HUD.show_game_over()
	$Music.stop()
	$Finished.play()

func _on_StartTimer_timeout():
	$Player.position = ($StartPosition.position)
#	$TestCPU.position = ($StartPosition.position)
	$CPU.position = ($StartPosition.position)
