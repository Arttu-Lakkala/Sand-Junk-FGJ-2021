extends KinematicBody2D

var vel : Vector2 = Vector2()
var speed = 100
var wavePushed = false;

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	
	if wavePushed:
		vel.x = 0
		vel.y = 350
		move_and_slide(vel, Vector2.UP)
	
	else:
		# reset horizontal velocity
		vel.x = 0
		vel.y = 0
	
		# movement inputs
		if Input.is_action_pressed("left"):
			vel.x -= speed
		if Input.is_action_pressed("right"):
			vel.x += speed
		if Input.is_action_pressed("up"):
			vel.y -= speed
		if Input.is_action_pressed("down"):
			vel.y += speed
		
		# applying the velocity
		vel = move_and_slide(vel, Vector2.UP)
	
		#move_and_collide(vel * delta)
	
		sprite.play("run")


func _on_Wave_body_entered(body):
	wavePushed = true


func _on_Wave_body_exited(body):
	wavePushed = false

