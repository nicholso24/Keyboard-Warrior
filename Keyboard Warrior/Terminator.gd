extends KinematicBody2D
onready var player = get_node("/root/Main/Player")
var velocity = Vector2(0,0)
export var speed = 400
signal player_hit
signal term_died
func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	velocity = position.direction_to(player.position) * speed

func _physics_process(delta):
	var object = move_and_collide(velocity * delta)
	if object:
		emit_signal("player_hit")
		player.hide()
	

func kill():
	emit_signal("term_died")
	queue_free()
	
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
