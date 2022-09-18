extends Area2D


signal enemy_killed(bodies)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var bodies = get_overlapping_bodies()
	if bodies.size() > 0:
		print(bodies)
	if Input.is_action_just_pressed("1_key"):
		for node in bodies:
			node.kill()
		emit_signal("enemy_killed", bodies)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
