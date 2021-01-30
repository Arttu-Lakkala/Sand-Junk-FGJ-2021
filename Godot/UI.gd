extends Control



onready var timeText = get_node("Time")


func set_time_text (time):
	timeText.text = str(time)
