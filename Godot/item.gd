extends Area2D


# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("ClearItems", self, "_onClearItems")
	get_parent().find_node("PlayerChar").connect("PickUp", self, "_onItemPick")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _onClearItems():
	self.queue_free()

func _onItemPick(picker):
	if(self.overlaps_body(picker)):
		print(self, "Item is pickable!")
