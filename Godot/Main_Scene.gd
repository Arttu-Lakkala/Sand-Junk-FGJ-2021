extends Node2D

var Item = load("res://item.tscn")


func _spaw_Items():
	var new_item = Item.instance()
	var new_item2 = Item.instance()
	add_child(new_item)
	add_child(new_item2)
	new_item.global_transform.origin = Vector2(-30,-170)
	new_item.global_transform.origin = Vector2(-30,-170)
	new_item2.global_transform.origin = Vector2(0,-150)
