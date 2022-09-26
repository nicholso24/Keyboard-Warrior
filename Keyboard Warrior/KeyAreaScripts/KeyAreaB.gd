extends Area2D

var keyUsed = true
var time = 10
var cooldownCol = Color(.9, .0, .0, .18)
var normalCol = Color(.08, 1.0, .0, .18)

func _process(delta):
	var bodies = get_overlapping_bodies()
#	if bodies.size() > 0:
#		print(bodies)
	if Input.is_action_just_pressed("b_key") and keyUsed:
		for node in bodies:
			node.kill()
		keyUsed = false
		get_node("/root/Main/ColorRect/KeyB").color = cooldownCol
		yield(get_tree().create_timer(time), "timeout")
		get_node("/root/Main/ColorRect/KeyB").color = normalCol
		print("Key ready")
		keyUsed = true
