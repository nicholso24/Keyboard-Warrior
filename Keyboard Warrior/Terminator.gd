extends KinematicBody2D
onready var player = get_node("/root/Main/Player")

export var speed = 400
var velocity = Vector2(0,0)
var dead = false

signal player_hit
signal term_died

func _ready():
	
	$AnimatedSprite_Walker.play()
	$AnimatedSprite_Walker.scale *= 1.25
	$CollisionShape2D.scale *= 1.25
	
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
	
	if dead:
		$AnimatedSprite_Walker.animation = "death"
		speed = 0
		
	else:
		$AnimatedSprite_Walker.animation = "run"
		$AnimatedSprite_Walker.flip_h = velocity.x < 0

func kill():
	emit_signal("term_died")
	dead = true
	$CollisionShape2D.set_deferred("disabled", true)
	yield($AnimatedSprite_Drone, "animation_finished")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
