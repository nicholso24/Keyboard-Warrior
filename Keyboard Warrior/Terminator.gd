extends KinematicBody2D
onready var player = get_node("/root/Main/Player")
var velocity = Vector2(0,0)
func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	velocity = position.direction_to(player.position) * 300

func _physics_process(delta):
		move_and_collide(velocity * delta)

func kill():
	queue_free()
	
	
