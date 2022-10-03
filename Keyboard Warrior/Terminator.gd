# Class for Terminator enemy
# Terminator shoots out at the player location when it spawn

extends KinematicBody2D
onready var player = get_node("/root/Main/Player")
var velocity = Vector2(0,0)
export var speed = 350
signal player_hit
signal term_died

var dead = false


func _ready():
	# Spins the enemy in a circle
	$AnimatedSprite.play()
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	yield(get_tree().create_timer(0.1), "timeout")
	self.rotate(PI / 2)
	
	$AnimatedSprite.animation = "run"
	
	# Gets player position once
	velocity = position.direction_to(player.position) * speed

func _physics_process(delta):
	if dead:
		$AnimatedSprite.animation = "death"
	else:
		$AnimatedSprite.animation = "run"
		# Object is NULL or the player
		# When robot collides with the player sets Object to not NULL
		# If it does not collide with anything Object is NULL
		# move_and_collide() also moves the player using a Vector2D()
		var object = move_and_collide(velocity * delta)
	
		# If player is hit
		if object:
			player.death()
			emit_signal("player_hit")
# If enemy is in key area when it is activated it calls the kill method on itself
func kill():
	emit_signal("term_died")
	dead = true
	$CollisionShape2D.set_deferred("disabled", true)
	yield($AnimatedSprite, "animation_finished")
	queue_free()
	
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
