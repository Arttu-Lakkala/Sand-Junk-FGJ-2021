extends Node2D

signal ClearItems

var Item = load("res://item.tscn")
var RNG = RandomNumberGenerator.new()

var xMin = -450
var xMax = 450
var yMin = -350
var yMax = -50

var itemList = []

export var itemsPerTide : int

func _spaw_Items():
	
	emit_signal("ClearItems")
	
	itemList.resize(itemsPerTide)
	
	for n in range(itemsPerTide):
					
		itemList[n] = Item.instance()
		itemList[n].global_transform.origin = Vector2(RNG.randi_range(xMin, xMax), RNG.randi_range(yMin, yMax))
		add_child(itemList[n])
	#var new_item = Item.instance()
	#var new_item2 = Item.instance()
	
	#add_child(new_item)
	#add_child(new_item2)
	
	#new_item.global_transform.origin = Vector2(-30,-170)
	#new_item2.global_transform.origin = Vector2(0,-150)
