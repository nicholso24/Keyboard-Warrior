extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("/root/Main/Player")
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite_Drone.play()
	yield(get_tree().create_timer(1),"timeout")

func _physics_process(delta):
	if player:
		yield(get_tree().create_timer(0.25), "timeout")
		velocity = Vector2.ZERO
		velocity = position.direction_to(player.position) * 100
		velocity = move_and_collide(velocity * delta)
		if velocity != 0:
			$AnimatedSprite_Drone.animation = "run"
			$AnimatedSprite_Drone.flip_h = velocity.x < 0
		else:
			$AnimatedSprite_Drone.animation = "idle"
		
func kill():
	$AnimatedSprite_Drone.animation = "death"
	queue_free()
