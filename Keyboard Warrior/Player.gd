extends KinematicBody2D

#signal hit
export (int) var speed = 400

var dead = false
onready var target = position
var velocity = Vector2()
signal restart
func _ready():
	hide()
	$AnimatedSprite.play()

func _input(event):
	if event.is_action_pressed("move"):
		target = get_global_mouse_position()
	if event.is_action_pressed("esc"):
		hide()
		emit_signal("restart")

func _physics_process(delta):
	if dead:
		pass
	else:
		velocity = position.direction_to(target) * speed
		# look_at(target)
		if position.distance_to(target) > 5:
			$AnimatedSprite.animation = "run"
			$AnimatedSprite.flip_h = velocity.x < 0
			#velocity = move_and_collide(velocity)
			var enemy = move_and_collide(velocity * delta)
		
		else:
			$AnimatedSprite.animation = "idle"
		

# Called when the player is inside the keyarea when it is activated
# Nothing should happen to the player
func kill():
	pass
	
# Spawns the player in
func start(new_position):
		dead = false
		position = new_position
		show()
		$CollisionShape2D.disabled = false

func death():
	dead = true
	$AnimatedSprite.animation = "death"
	yield($AnimatedSprite, "animation_finished")
	hide()





func _on_HUD_nux_mode():
	# Nux mode is on so makes the playable character immune
	collision_layer = 4
	collision_mask = 4


func _on_HUD_normal_mode():
	# Toggles off nux mode
	collision_layer = 1
	collision_mask = 1
