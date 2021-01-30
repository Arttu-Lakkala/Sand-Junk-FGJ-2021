extends Control


func _on_Button2_pressed():
	Global.players = 2
	get_tree().change_scene("res://Main_Scene.tscn")


func _on_Button_pressed():
	Global.players = 1
	get_tree().change_scene("res://Main_Scene.tscn")
