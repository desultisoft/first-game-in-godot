extends Node

var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."

func become_host():
	print("Became Host Pressed")
	MultiplayerManager.host()
	%MultiplayerHUD.hide()
	
func join():
	print("Joined Game Pressed")
	MultiplayerManager.join()
	%MultiplayerHUD.hide()
