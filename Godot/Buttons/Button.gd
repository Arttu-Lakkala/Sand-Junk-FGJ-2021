extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = owner.get_node("FadeIn").get_node("FadeInAnimation")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	grab_focus()

func _on_Button_pressed():
	get_tree().change_scene("res://Main_Scene.tscn")
