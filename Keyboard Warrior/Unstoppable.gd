extends KinematicBody2D
onready var player = get_node("/root/Main/Player")
var velocity
export var speed = 100
signal player_hit

func _on_spawn(var pos):
	velocity = position.direction_to(pos.position) * speed

func _physics_process(delta):
	var object = move_and_collide(velocity * delta)
	
	if object:
		emit_signal("player_hit")
		player.hide()
	
func kill():
	self.scale = Vector2(1,1)
	
	




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
