extends Area2D

signal ItemPicked(Item)

enum Itemtype{TIRE = 1, BIKE = 50, RANGE_END = 100}

var RNG = RandomNumberGenerator.new()
var type = Itemtype.BIKE
var pickable = true
var pickupTimer = 0.0
# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	
	RNG.randomize()
	get_parent().connect("ClearItems", self, "_onClearItems")
	get_parent().find_node("PlayerChar").connect("PickUp", self, "_onItemPick")
	if(Global.players>1):
		get_parent().find_node("Player2Char").connect("PickUp", self, "_onItemPick")
	
	self.type = RNG.randi_range(1, Itemtype.RANGE_END)
		
	if self.type < Itemtype.BIKE:
		$Wheel.show()
		$BikeBody.hide()
	else:
		$Wheel.hide()
		$BikeBody.show()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _onClearItems():
	self.queue_free()

func _onItemPick(picker):
	if(self.overlaps_body(picker) && self.pickable):
		picker.addItem(type)
		self.pickable = false
		self.hide()
		$AnimatedSprite.show()
		$AnimatedSprite.play("poof")
		
