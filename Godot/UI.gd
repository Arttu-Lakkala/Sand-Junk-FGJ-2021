extends Control



onready var timeText = get_node("Time")


func set_time_text (time):
	timeText.text = str(time)

func set_player1 (now, maximum):
	$PlayerInfo/Amount.text = str(now)
	$PlayerInfo/Space.text = str(maximum)
	$PlayerInfo/PlayerScore.text = ("Score: " + str(Global.player1score))
	
func set_player2 (now, maximum):
	$Player2Info/Amount2.text = str(now)
	$Player2Info/Space2.text = str(maximum)
	$Player2Info/PlayerScore2.text = ("Score: " + str(Global.player2score))
