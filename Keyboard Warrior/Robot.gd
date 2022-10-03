extends KinematicBody2D
signal player_hit

export (int) var speed = 150
export var dead = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("/root/Main/Player")


var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite_Drone.play()
	yield(get_tree().create_timer(1),"timeout")

func _physics_process(delta):
	yield(get_tree().create_timer(0.25), "timeout")

	velocity = position.direction_to(player.position) * speed
	var object = move_and_collide(velocity * delta)
	
	if object:
	  emit_signal("player_hit")
	  
	if dead:
		$AnimatedSprite_Drone.animation = "death"
		speed = 0
		
	else:
		$AnimatedSprite_Drone.animation = "run"
		$AnimatedSprite_Drone.flip_h = velocity.x < 0
		
func kill():
	emit_signal("robot_died")
	dead = true
	$CollisionShape2D.set_deferred("disabled", true)
	yield($AnimatedSprite_Drone, "animation_finished")
	queue_free()

