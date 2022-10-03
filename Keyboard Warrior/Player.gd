extends KinematicBody2D

#signal hit
export (int) var speed = 500
export var dead = false

onready var target = position
var velocity = Vector2()

signal restart

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("move"):
		target = get_global_mouse_position()
	if event.is_action_pressed("esc"):
		hide()
		emit_signal("restart")

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if dead:
		$AnimatedSprite_Player.animation = "death"
		$AnimatedSprite_Player.flip_h = velocity.x < 0
	
	if position.distance_to(target) > 5:
		$AnimatedSprite_Player.animation = "run"
		$AnimatedSprite_Player.flip_h = velocity.x < 0
		#velocity = move_and_collide(velocity)
		var enemy = move_and_collide(velocity * delta)
		
		#if enemy:
				#emit_signal("hit")
				#hide()
	else:
		
		$AnimatedSprite_Player.animation = "idle"
		
func kill():
	dead = true
	
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func player_hit():
	$AnimatedSprite_Player.flip_h = velocity.x < 0
	$AnimatedSprite_Player.animation = "death"
	hide()

func _on_HUD_nux_mode():
	# Nux mode is on so makes the playable character immune
	collision_layer = 4
	collision_mask = 4


func _on_HUD_normal_mode():
	# Toggles off nux mode
	collision_layer = 1
	collision_mask = 1
