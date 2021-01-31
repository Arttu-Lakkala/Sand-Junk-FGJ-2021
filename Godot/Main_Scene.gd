extends Node2D

signal ClearItems

var Item = load("res://item.tscn")
var RNG = RandomNumberGenerator.new()

var ItemValues = [[15, 30], [45, 60]]

onready var ui = get_node("CanvasLayer/UI")
onready var time_start = OS.get_unix_time()
var Time = 60


var xMin = -450
var xMax = 450
var yMin = -315
var yMax = -50

var itemList = []

export var itemsPerTide : int

func _ready():
	Global.player1score = 0
	Global.player2score = 0
	if (Global.players==1):
		get_node("Player2Char").queue_free()
		get_node("Towel2").queue_free()
		get_node("CanvasLayer/UI/Player2Info").queue_free()

func _process(delta):
	ui.set_time_text(Time - ((OS.get_unix_time() - time_start)))
	ui.set_player1($PlayerChar.items_held.size() ,$PlayerChar.maxItems)
	if(Global.players>1):
		ui.set_player2($Player2Char.items_held.size() ,$Player2Char.maxItems)
	if(Time-(OS.get_unix_time() - time_start)==0):
		if(Global.player1score>Global.highScore):
			Global.highScore = Global.player1score
		if(Global.player2score>Global.highScore):
			Global.highScore = Global.player2score
		get_tree().change_scene("res://End_scene.tscn")
	

func _spaw_Items():
	
	emit_signal("ClearItems")
	
	itemList.resize(itemsPerTide)
	
	for n in range(itemsPerTide):
					
		var newItem = Item.instance()	#itemList[n] = Item.instance()
		newItem.position = Vector2(RNG.randi_range(xMin, xMax), RNG.randi_range(yMin, yMax))
		#itemList[n].global_transform.origin = Vector2(RNG.randi_range(xMin, xMax), RNG.randi_range(yMin, yMax))
		add_child(newItem)


func _on_PlayerChar_ScoreItems(player, items):
	for item in items:
		#Global.player1score += item
		Global.player1score += RNG.randi_range(ItemValues[item][0], ItemValues[item][1]) 
	#print(Global.player1score)


func _on_Player2Char_ScoreItems(player, items):
	for item in items:
		#Global.player2score += item 
		Global.player2score += RNG.randi_range(ItemValues[item][0], ItemValues[item][1]) 
	#print(Global.player2score)
