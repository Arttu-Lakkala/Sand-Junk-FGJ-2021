extends KinematicBody2D

signal PickUp(picker)
signal ScoreItems(player, items)

var vel : Vector2 = Vector2()
var maxItems = 3
var wavePushed = false
var pickingUp = false
var stunned = false
var pickupTimer = 0.0
var stunTimer = 0.0
var items_held = []
var speed = 100

export var baseSpeed : float
export var  slowdownPerItem : float

onready var sprite = $AnimatedSprite

func _ready():
	var speed = self.calcSpeed()

func _physics_process(delta):
	
	position.x = clamp(position.x, -475, 475)
	position.y = clamp(position.y, -400, 150)
	
	vel.x = 0
	vel.y = 0	
	
	if wavePushed:
		vel.x = 0
		vel.y = 200
	
	elif stunned:
		stunTimer -= delta
		
		if stunTimer < 0.0:
			stunned = false
			get_node("CollisionShape2D/StunParticles").set_emitting(false)
			stunTimer = 0
		
	
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
		if (Input.is_action_pressed("ItemPickup")):
			if((items_held.size()<maxItems)):
				emit_signal("PickUp", self)
			else:
				$NoPickup.play()
				
	vel = move_and_slide(vel, Vector2.UP)
	#animation and sound
	if(stunned):
		pass
	elif(wavePushed):
		sprite.play("water")
		$Footsteps.stop()
	elif(pickingUp):
		$Footsteps.stop()
	elif ((vel.y != 0)||(vel.x != 0)):
		sprite.play("run")
		if(!$Footsteps.playing):
			$Footsteps.play()
	else:
		$Footsteps.stop()
		sprite.play("idle")

func _on_Wave_body_entered(body):
	if(body == self):
		items_held = []
		$Drowning.play()
		wavePushed = true
		self.calcSpeed()


func _on_Wave_body_exited(body):
	if(body == self):
		$Drowning.stop()
		$Stunned.play()
		get_node("CollisionShape2D/StunParticles").set_emitting(true)
		sprite.play("stun")
		wavePushed = false
		stunned = true
		stunTimer = 1.0

func addItem(item):
	$Pickup.play()
	pickingUp = true
	pickupTimer = 1.2
	sprite.play("pickup")
	items_held.append(item)
	self.calcSpeed()
		
func _on_Towel_body_entered(body):
	if(body == self):
		#jos tavaraa
		if(items_held.size()>0):
			#lähetetään
			emit_signal("ScoreItems", body, items_held)
		#poistetaan
		items_held = []
		self.calcSpeed()

func calcSpeed():
	self.speed = baseSpeed - (items_held.size() *  slowdownPerItem)
