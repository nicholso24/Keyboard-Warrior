extends KinematicBody2D
signal player_hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("/root/Main/Player")
signal robot_died
export var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite_Drone.play()
	yield(get_tree().create_timer(1),"timeout")

func _physics_process(delta):
	if player:
		yield(get_tree().create_timer(0.25), "timeout")
		$AnimatedSprite_Drone.animation = "run"
		var velocity = position.direction_to(player.position) * speed
		var object = move_and_collide(velocity * delta)
		
		if object:
			emit_signal("player_hit")
			player.hide()
	else:
			$AnimatedSprite_Drone.animation = "idle"
		
func kill():
	emit_signal("robot_died")
	$AnimatedSprite_Drone.animation = "death"
	queue_free()
