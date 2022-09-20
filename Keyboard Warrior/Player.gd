extends KinematicBody2D

signal hit
export (int) var speed = 500

onready var target = position
var velocity = Vector2()

func _ready():
	$AnimatedSprite.play()

func _input(event):
	if event.is_action_pressed("move"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 5:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
		
		#velocity = move_and_collide(velocity)
		var player = move_and_collide(velocity * delta)
		
		if player:
				hide()
				yield(get_tree().create_timer(5), "timeout")
				show()
	else:
		$AnimatedSprite.animation = "idle"
		
		
func kill():
	print("HAHAHA")



