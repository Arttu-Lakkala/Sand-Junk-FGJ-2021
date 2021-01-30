extends Control


func _ready():
	var socre1 =$Score1
	socre1.text = str(Global.player1score)


func _on_AgainButton_pressed():
	get_tree().change_scene("res://Title screen.tscn")


func _on_EndButton_pressed():
	get_tree().quit()
