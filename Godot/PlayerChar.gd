extends KinematicBody2D

var vel : Vector2 = Vector2()

var speed = 100

func _physics_process(delta):
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
