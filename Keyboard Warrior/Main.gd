extends Node

var score = 0
var scene = load("res://Robot.tscn")

func _ready():
	pass
func new_game():
	score = 0
	$StartTimer.start()
	$HUD.show_message("Get ready gamer!")
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	yield($StartTimer,"timeout")
	$ScoreTimer.start()
	$RobotTimer.start()
	
func game_over():
	get_tree().call_group("mobs","queue_free")
	$ScoreTimer.stop()
	$RobotTimer.stop()
	$HUD.show_game_over()
	

func _on_RobotTimer_timeout():
	var robot = scene.instance()
	add_child(robot)
	
	robot.position = $RobotSpawn.get_position()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
