extends Node

var scene = load("res://Robot.tscn")

<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
func _on_RobotTimer_timeout():
	var robot = scene.instance()
	add_child(robot)
	
	robot.position = $RobotSpawn.get_position()
