extends KinematicBody2D

var velocity = Vector2(0,0)

func _on_spawn(var pos):
	velocity = position.direction_to(pos.position) * 200

func _physics_process(delta):
	move_and_collide(velocity * delta)

func kill():
	self.scale = Vector2(1,1)
	
	


