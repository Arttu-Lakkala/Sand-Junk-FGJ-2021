extends Area2D


# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("ClearItems", self, "_onClearItems")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _onClearItems():
	self.queue_free()
