extends KinematicBody2D

signal PickUp(picker)
signal ScoreItems(player, items)

var vel : Vector2 = Vector2()
var speed = 100
var maxItems = 3
var wavePushed = false
var pickingUp = false
var pickupTimer = 0.0
var items_held = []


onready var sprite = $AnimatedSprite


func _physics_process(delta):
	
	vel.x = 0
	vel.y = 0	
	
	if wavePushed:
		vel.x = 0
		vel.y = 200
	
	elif pickupTimer > 0:
		
		pickupTimer -= delta
		
		if pickupTimer < 0:
			pickupTimer = 0.0
			pickingUp = false
		
	
	else:
	
		# movement inputs
		if Input.is_action_pressed("left"):
			vel.x -= speed
		if Input.is_action_pressed("right"):
			vel.x += speed
		if Input.is_action_pressed("up"):
			vel.y -= speed
		if Input.is_action_pressed("down"):
			vel.y += speed
		#ei nosteta jos liikaa tavaraa
		if (Input.is_action_pressed("ItemPickup")&&(items_held.size()<maxItems)):
			emit_signal("PickUp", self)
				
				
	vel = move_and_slide(vel, Vector2.UP)
	#animation
	if(wavePushed):
		sprite.play("water")
	elif(pickingUp):
		pass
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
	pickingUp = true
	pickupTimer = 1.5
	sprite.play("pickup")
	items_held.append(item)
		
func _on_Towel_body_entered(body):
	if(body == self):
		#jos tavaraa
		if(items_held.size()>0):
			#lähetetään
			emit_signal("ScoreItems", body, items_held)
		#poistetaan
		items_held = []
