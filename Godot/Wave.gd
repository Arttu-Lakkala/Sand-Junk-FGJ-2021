extends Area2D

var rng = RandomNumberGenerator.new()

export var speed : int = 200


 
onready var startY : float = position.y
onready var targetY : float = position.y

func _physics_process (delta):

	# move to the "targetY" position
	position.y = move_to(position.y, targetY, speed * delta)

	# if we're at our target, move in the other direction
	if position.y == targetY:
		if targetY == startY:
			var moveDist = 0
			if(rng.randi_range(0,3) == 3):
				moveDist = 400
			else:
				moveDist = 50
			targetY = position.y + moveDist
		
		else:
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
