extends KinematicBody2D

signal PickUp(picker)

var vel : Vector2 = Vector2()
var speed = 100
var wavePushed = false
var available_items = []


onready var sprite = $AnimatedSprite

func _physics_process(delta):
	
	if wavePushed:
		vel.x = 0
		vel.y = 200
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
		if Input.is_action_pressed("ItemPickup"):
			emit_signal("PickUp", self)
					
		# applying the velocity
		vel = move_and_slide(vel, Vector2.UP)
	
		#move_and_collide(vel * delta)
	
		sprite.play("run")
	#animation
	if(wavePushed):
		sprite.play("water")
	elif ((vel.y != 0)||(vel.x != 0)):
		sprite.play("run")
	else:
		sprite.play("idle")

func _on_Wave_body_entered(body):
	if(body == self):
		$Drowning.play()
		wavePushed = true


func _on_Wave_body_exited(body):
	if(body == self):
		$Drowning.stop()
		wavePushed = false

