extends KinematicBody2D
onready var player = get_node("/root/Main/Player")
var velocity
export var speed = 100
signal player_hit

func _on_spawn(var pos):
	# Determines spawn location
	# Used in the Main.gd
	velocity = position.direction_to(pos.position) * speed
	$AnimatedSprite.animation = "run"
	$AnimatedSprite.play()

func _physics_process(delta):
	$AnimatedSprite.flip_h = velocity.x < 0
	# Object is NULL or the player
	# When robot collides with the player sets Object to not NULL
	# If it does not collide with anything Object is NULL
	# move_and_collide() also moves the player using a Vector2D()
	var object = move_and_collide(velocity * delta)
	
	# If player is hit
	if object:
		player.death()
		emit_signal("player_hit")

# Method called when the enemy is inside a keyarea when it is activated
# The Unstoppable enemy cannot be killed, but instead grows bigger
func kill():
	self.scale = Vector2(1,1)
	
	




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
