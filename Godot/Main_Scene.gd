extends Node2D

signal ClearItems

var Item = load("res://item.tscn")
var RNG = RandomNumberGenerator.new()

onready var ui = get_node("CanvasLayer/UI")
onready var time_start = OS.get_unix_time()
var Time = 60


var xMin = -450
var xMax = 450
var yMin = -350
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
		get_tree().change_scene("res://End_scene.tscn")
	

func _spaw_Items():
	
	emit_signal("ClearItems")
	
	itemList.resize(itemsPerTide)
	
	for n in range(itemsPerTide):
					
		itemList[n] = Item.instance()
		itemList[n].global_transform.origin = Vector2(RNG.randi_range(xMin, xMax), RNG.randi_range(yMin, yMax))
		add_child(itemList[n])


func _on_PlayerChar_ScoreItems(player, items):
	for item in items:
		Global.player1score += item 
	print(Global.player1score)

func _on_PlayerChar2_ScoreItems(player, items):
	for item in items:
		Global.player2score += item 
	print(Global.player2score)
