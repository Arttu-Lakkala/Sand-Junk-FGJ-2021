extends Control


func _ready():
	var socre1 =$Score1
	socre1.text = str(Global.player1score)
	if (Global.players==1):
		get_node("player2").queue_free()
		get_node("Label1_2").queue_free()
		get_node("Label2_2").queue_free()
		get_node("Score2").queue_free()
	else:
		$Socre2.text = str(Global.player2score)

func _on_AgainButton_pressed():
	get_tree().change_scene("res://Title screen.tscn")


func _on_EndButton_pressed():
	get_tree().quit()
