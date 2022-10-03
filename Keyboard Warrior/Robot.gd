
# Class for Robot enemy
# Robot enemy follows player continously
extends KinematicBody2D
signal player_hit
signal robot_died

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Gets the player from the main node
onready var player = get_node("/root/Main/Player")

var speed = 150
var dead = false
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite_Drone.play()
	yield(get_tree().create_timer(1),"timeout")

func _physics_process(delta):
	yield(get_tree().create_timer(0.25), "timeout")
	
	# Gets a Vector2() to the player's position
	velocity = position.direction_to(player.position) * speed
	
	# Object is NULL or the player
	# When robot collides with the player sets Object to not NULL
	# If it does not collide with anything Object is NULL
	# move_and_collide() also moves the player using a Vector2D()
	var object = move_and_collide(velocity * delta)
	
	# If collided with the player
	if object:
	  player.death()
	  emit_signal("player_hit")
	  
	 
	# If the robot is dead
	if dead:
		$AnimatedSprite_Drone.animation = "death"
		speed = 0
	else:
		$AnimatedSprite_Drone.animation = "run"
		$AnimatedSprite_Drone.flip_h = velocity.x < 0
		
# Kills the robot when it enters a keyarea that has been activated
func kill():
	emit_signal("robot_died")
	dead = true
	$CollisionShape2D.set_deferred("disabled", true)
	yield($AnimatedSprite_Drone, "animation_finished")
	queue_free()

