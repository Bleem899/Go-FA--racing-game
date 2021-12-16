extends Area2D
signal hit
signal player_win
signal cpu_win

func _on_Goal_body_entered(_body):
#	game_over()
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	$Completed.play()

func start():
#	position.x = 988
#	position.y = rand_range(32, 560)
	show()
	$CollisionShape2D.disabled = false

func _on_Goal_body_shape_entered(body_id, body, _body_shape, _local_shape):
	print(body_id)
	if body_id == 1329:
		body.hide()
		emit_signal("player_win")
	else:
		body.hide()
		emit_signal("cpu_win")
