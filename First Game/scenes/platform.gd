extends AnimatableBody2D

@export var animation_player : AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if animation_player:
		multiplayer.peer_connected.connect(_on_player_connected)

func _on_player_connected(id):
	if not multiplayer.is_server():
		animation_player.stop()
		animation_player.set_active(false)
