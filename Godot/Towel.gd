extends Area2D

var RNG = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	RNG.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func itemAdd(texture):
	
	var newItem = Sprite.new()
	newItem.texture	= texture
	
	newItem.scale = Vector2(0.03, 0.03)
	newItem.position = self.get_parent().position + Vector2(RNG.randf_range(-50.0, 50.0), RNG.randf_range(-50.0, 50.0))
	newItem.transform = newItem.get_transform().rotated(RNG.randf_range(0, 360.0))
		
	self.add_child(newItem)
