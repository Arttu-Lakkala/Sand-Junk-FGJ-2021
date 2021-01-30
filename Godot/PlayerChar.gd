extends KinematicBody2D

signal PickUp(picker)
signal ScoreItems(player, items)

var vel : Vector2 = Vector2()
var speed = 100
var wavePushed = false
var items_held = []


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
	if (!wavePushed && ((vel.y != 0)||(vel.x != 0))):
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

func addItem(item):
	print(item, "Player picks up item")
	items_held.append(item)


func _on_Towel_body_entered(body):
	emit_signal("ScoreItems", body, items_held)	
