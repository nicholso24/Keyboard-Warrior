extends KinematicBody2D

signal hit
export (int) var speed = 500
var screen_size = Vector2.ZERO

onready var target = position
var velocity = Vector2()
func _ready():
	screen_size = get_viewport_rect().size
	print(screen_size)
	hide()
	
func _input(event):
	if event.is_action_pressed("move"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 5:
		#velocity = move_and_collide(velocity)
		var enemy = move_and_collide(velocity * delta)
		if enemy:
			hide()
			$CollisionShape2D.set_deferred("disabled",true)
			emit_signal("hit")
			
			
		
		
				
func kill():
	print("HAHAHA")
	
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
	




