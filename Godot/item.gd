extends Area2D

signal ItemPicked(Item)

enum Itemtype{TIRE = 1, BIKE, BOOT}

var type = Itemtype.TIRE 
var pickable = true
var pickupTimer = 0.0
# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("ClearItems", self, "_onClearItems")
	get_parent().find_node("PlayerChar").connect("PickUp", self, "_onItemPick")
	if(Global.players>1):
		get_parent().find_node("Player2Char").connect("PickUp", self, "_onItemPick")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _onClearItems():
	self.queue_free()

func _onItemPick(picker):
	if(self.overlaps_body(picker) && self.pickable):
		picker.addItem(type)
		self.pickable = false
		$Wheel.hide()
		$AnimatedSprite.show()
		$AnimatedSprite.play("poof")
		
