extends KinematicBody2D
onready var player = get_node("/root/Main/Player")
var velocity
export var speed = 100
signal player_hit

func _on_spawn(var pos):
	$AnimatedSprite_Tank.play()
	velocity = position.direction_to(pos.position) * speed

func _physics_process(delta):
	var object = move_and_collide(velocity * delta)
	$AnimatedSprite_Tank.animation = "run"
	$AnimatedSprite_Tank.flip_h = velocity.x < 0
	
	if object:
		emit_signal("player_hit")
	
func kill():
	self.scale = Vector2(1,1)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
