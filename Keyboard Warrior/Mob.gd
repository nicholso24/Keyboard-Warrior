extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

#temp
var speed = 200.0
var dead = false

onready var thing = get_node("/root/main/KeyArea")

var currently_In = []

#
#func _ready():
#	$AnimatedSprite.playing = true
#	var mob_types = $AnimatedSprite.frames.get_animation_names()
#	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
#
#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free()

func _process(delta):
	####################################extra
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
		
	if direction.length() > 0:
		direction = direction.normalized()
		
		
	position += direction * speed * delta
	
	#####################################extra end
	
	for i in currently_In:
		if Input.is_action_just_pressed("1_key") and i == $"%AreaKey1":
			print("got here")
			hide()
			$CollisionShape2D.set_deferred("disabled", true)
		

func kill():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
