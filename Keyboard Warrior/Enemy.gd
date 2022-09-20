extends KinematicBody2D

onready var player = get_node("/root/Main/Player")
var velocity

func _physics_process(delta):
	if player:
		
		yield(get_tree().create_timer(0.25), "timeout")
		velocity = Vector2.ZERO
		velocity = position.direction_to(player.position) * 200
		velocity = move_and_slide(velocity * delta)
		
