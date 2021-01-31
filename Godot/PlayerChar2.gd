extends KinematicBody2D

signal PickUp(picker)

var vel : Vector2 = Vector2()
var speed = 100
var maxItems = 3
var wavePushed = false
var pickingUp = false
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
		if Input.is_action_pressed("left2"):
			vel.x -= speed
		if Input.is_action_pressed("right2"):
			vel.x += speed
		if Input.is_action_pressed("up2"):
			vel.y -= speed
		if Input.is_action_pressed("down2"):
			vel.y += speed
		if (Input.is_action_pressed("ItemPickup2")&&(items_held.size()<maxItems)):
			emit_signal("PickUp", self)
					
		# applying the velocity
		vel = move_and_slide(vel, Vector2.UP)
	
	#animation
	if(wavePushed):
		sprite.play("water")
	elif ((vel.y != 0)||(vel.x != 0)):
		sprite.play("run")
	else:
		sprite.play("idle")

func _on_Wave_body_entered(body):
	if(body == self):
		items_held = []
		$Drowning.play()
		wavePushed = true

func _on_Wave_body_exited(body):
	if(body == self):
		$Drowning.stop()
		wavePushed = false

func addItem(item):
	print(item, "Player picks up item")
	pickingUp = true
	sprite.play("pickup")
	items_held.append(item)
	print(items_held.size())

func _on_Towel2_body_entered(body):
	if(body == self):
		#jos tavaraa
		if(items_held.size()>0):
			#lähetetään
			emit_signal("ScoreItems", body, items_held)
		#poistetaan
		items_held = []
