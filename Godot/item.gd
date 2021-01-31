extends Area2D

signal ItemPicked(Item)

export var poofDuration : float

enum Itemtype{TIRE = 1, BIKE = 50, RANGE_END = 100}

var RNG = RandomNumberGenerator.new()
var type = Itemtype.BIKE
var pickable = true
var pickupTimer = 0.0
var pickedUp = false
var poofing = false
var poofTime = 0.0

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

func _process(delta):
	
	if poofing:
		
		self.poofTime -= delta
		
		if poofTime < 0.0:
			self.poofing = false
			self.poofTime = 0.0
			
			self.hide()

func _onItemPick(picker):
	if(self.overlaps_body(picker) && self.pickable):
		picker.addItem(type)
		self.pickable = false
		self.pickedUp = false
						
		$Wheel.hide()
		$BikeBody.hide()
		
		$AnimatedSprite.show()
		$AnimatedSprite.play("poof")
		
		self.poofing = true
		self.poofTime = poofDuration
