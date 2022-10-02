extends Node

var score = 0
var scene = load("res://Robot.tscn")
var term = load("res://Terminator.tscn")
var unstop = load("res://Unstoppable.tscn")
func _ready():
	randomize()
func update():
	$HUD.update_score(score)
	if score > 250:
		$UnstopTimer.wait_time = 4
		$RobotTimer.wait_time = 2
		$TermTimer.wait_time = 1
	elif score > 100:
		$UnstopTimer.wait_time = 7
		$RobotTimer.wait_time = 3
	elif score > 50:
		$UnstopTimer.wait_time = 9
		$RobotTimer.wait_time = 4
		$TermTimer.wait_time = 2
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
	$TermTimer.start()
	$UnstopTimer.start()
	$Music.play()
	

	
func game_over():
	get_tree().call_group("mobs","queue_free")
	$ScoreTimer.stop()
	$RobotTimer.stop()
	$TermTimer.stop()
	$HUD.show_game_over()
	$UnstopTimer.stop()
	$Music.stop()
	

func _on_RobotTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawn
	mob_spawn_location.unit_offset = randf()
	
	var robot = scene.instance()
	add_child(robot)
	robot.connect("player_hit",self,"game_over")
	robot.connect("robot_died",self,"robot_died")
	
	
	robot.position = mob_spawn_location.position
	
	#robot.position = $RobotSpawn.get_position()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_TermTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawn
	mob_spawn_location.unit_offset = randf()
	
	var robot = term.instance()
	add_child(robot)
	robot.connect("player_hit",self,"game_over")
	robot.connect("term_died",self,"term_died")
	
	robot.position = mob_spawn_location.position
	


func _on_UnstopTimer_timeout():
	var robot = unstop.instance()
	add_child(robot)
	robot.connect("player_hit",self,"game_over")
	var dir = true
	if randi() % 2:
		dir = false
	if dir:
		var odd = true
		if randi() % 2:
			odd = false
		if odd:
			var mob_spawn_location = $UnstopPosition1
			robot.position = mob_spawn_location.position
			robot._on_spawn($UnstopPosition2)
		
		else:
			var mob_spawn_location = $UnstopPosition2
			robot.position = mob_spawn_location.position
			robot._on_spawn($UnstopPosition1)
			
	else:
		var odd = true
		if randi() % 2:
			odd = false
		if odd:
			var mob_spawn_location = $UnstopPosition3
			robot.position = mob_spawn_location.position
			robot._on_spawn($UnstopPosition4)
		
		else:
			var mob_spawn_location = $UnstopPosition4
			robot.position = mob_spawn_location.position
			robot._on_spawn($UnstopPosition3)

func term_died():
	score = score + 4
	update()
	
func robot_died():
	score = score + 8
	update()
