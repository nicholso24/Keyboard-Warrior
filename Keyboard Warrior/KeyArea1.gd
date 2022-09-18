extends Area2D


func _process(delta):
	var bodies = get_overlapping_bodies()
#	if bodies.size() > 0:
#		print(bodies)
	if Input.is_action_just_pressed("1_key"):
		for node in bodies:
			node.kill()
			
