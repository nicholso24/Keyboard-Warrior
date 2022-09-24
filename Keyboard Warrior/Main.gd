extends Node

var score = 0
var scene = load("res://Robot.tscn")
func _ready():
	randomize()

func new_game():
	score = 0
	
	$StartTimer.start()
	$HUD.show_message("Get ready...")
	
	get_tree().call_group("mobs","queue_free")
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
	var mob_spawn_location = $MobPath/MobSpawn
	mob_spawn_location.unit_offset = randf()
	
	var robot = scene.instance()
	add_child(robot)
	
	robot.position = mob_spawn_location.position
	
	#robot.position = $RobotSpawn.get_position()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
