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
	if (Global.players==1):
		get_node("Player2Char").queue_free()

func _process(delta):
	ui.set_time_text(Time - ((OS.get_unix_time() - time_start)))


func _spaw_Items():
	
	emit_signal("ClearItems")
	
	itemList.resize(itemsPerTide)
	
	for n in range(itemsPerTide):
					
		itemList[n] = Item.instance()
		itemList[n].global_transform.origin = Vector2(RNG.randi_range(xMin, xMax), RNG.randi_range(yMin, yMax))
		add_child(itemList[n])


func _on_PlayerChar_ScoreItems(player, items):
	var score = 0
	for item in items:
		score += item
	
	#Global.player1score 
