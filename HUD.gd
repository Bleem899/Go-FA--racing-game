extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_round_over(winner):
	if winner == 0:
		show_message("Player Wins!!")
	else:
		show_message("AI Wins!!")
	
	yield($MessageTimer, "timeout")

	$Message.text = "Go FA*!"
	$Message.show()

	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func show_game_over():
	show_message("Game Over")
	yield(get_tree().create_timer(3), "timeout")
	yield($MessageTimer, "timeout")

	$Message.text = "Go FA*!"
	$Message.show()

	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_score(PlayerScore, EnemyScore):
	$PlayerScore.text = "My score: " + str(PlayerScore)
	$PlayerScore.show()
	$CPUScore.text = "AI score: " + str(EnemyScore)
	$CPUScore.show()

func _on_MessageTimer_timeout():
	$Message.text = "GO!!"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	$Message.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageTimer.start()
	emit_signal("start_game")
