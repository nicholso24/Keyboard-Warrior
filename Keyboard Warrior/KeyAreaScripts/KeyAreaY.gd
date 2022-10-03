extends Area2D

var keyUsed = true
var time = 10
var colors = [Color(.9, .0, .0, .18), Color(0.9 , 0.5, 0, .18), Color(0.9, 1.0, 0, .18), Color(.08, 1.0, .0, .18)]

func _process(delta):
	var bodies = get_overlapping_bodies()
#	if bodies.size() > 0:
#		print(bodies)
	if Input.is_action_just_pressed("y_key") and keyUsed:
		for node in bodies:
			node.kill()
		keyUsed = false
		for x in range(3):
			get_node("/root/Main/ColorRect/KeyY").color = colors[x]
			yield(get_tree().create_timer(time/3), "timeout")
		get_node("/root/Main/ColorRect/KeyY").color = colors[3]
		print("Key ready")
		keyUsed = true
