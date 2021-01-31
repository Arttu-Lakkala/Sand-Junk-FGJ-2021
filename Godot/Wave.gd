extends Area2D

var rng = RandomNumberGenerator.new()

export var speed : int = 200
var waveStrength = 7
onready var Main = get_parent()
 
onready var startY : float = position.y
onready var targetY : float = position.y

onready var WaveSound =$mildWind
onready var CrashSound =$BigWind


func _physics_process (delta):

	# move to the "targetY" position
	position.y = move_to(position.y, targetY, speed * delta)

	# if we're at our target, move in the other direction
	if position.y == targetY:
		#alussa
		if targetY == startY:
			var moveDist = 0
			if(waveStrength >= 4):
				CrashSound.play()
				moveDist = 400
				speed =200
			else:
				WaveSound.play()
				moveDist = 50
				speed = 25
				
			targetY = position.y + moveDist
			
		#perillä 
		else:
			if (targetY==0):
				waveStrength=0
				$CollisionShape2D/FoamEffect.amount  = 100
				Main._spaw_Items()
			else:
				waveStrength = (waveStrength + rng.randi_range(1,2))
				if(waveStrength>=4):
					$CollisionShape2D/FoamEffect.amount  = 600
				else:
					$CollisionShape2D/FoamEffect.amount  = 100
			targetY = startY
			
			
		
		
func move_to (current, to, step):
 
	var new = current

	# are we moving positive?
	if new < to:
		new += step

		if new > to:
			new = to
	# are we moving negative?
	else:
		new -= step

		if new < to:
			new = to
	return new
