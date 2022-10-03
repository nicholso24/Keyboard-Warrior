extends CanvasLayer

signal start_game
signal nux_mode
signal normal_mode
func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	
	yield($MessageTimer,"timeout")
	$MessageLabel.text = "Get Ready Gamer!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0),"timeout")
	$StartButton.show()
	$NuxButton.show()


func _on_StartButton_pressed():
	$StartButton.hide()
	$NuxButton.hide()
	emit_signal("start_game")



func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_CheckButton_toggled(button_pressed):
	if(button_pressed):
		emit_signal("nux_mode")
	else:
		emit_signal("normal_mode")
