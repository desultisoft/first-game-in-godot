extends Node

const SERVER_PORT = 8080
const SERVER_IP = "127.0.0.1"

var multiplayer_scene = preload("res://scenes/Multiplayer_Player.tscn")

var _players_spawn_node

var host_mode_enabled = false
var multiplayer_mode_enabled = false
var respawn_point = Vector2(30,20)

func host():
	print("Starting Host!")
	
	host_mode_enabled = true
	multiplayer_mode_enabled = true
	
	_players_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	multiplayer.multiplayer_peer = server_peer
	
	#Connect to the signal of the server that corresponds to a player joining
	multiplayer.peer_connected.connect(_add_player_to_game)
	print("Connecting Signal!")
	multiplayer.peer_disconnected.connect(_remove_player_from_game)
	
	_remove_single_player()
	_add_player_to_game(1)
	
	
func join():
	multiplayer_mode_enabled = true
	print("Player Joined")
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	multiplayer.multiplayer_peer = client_peer
	
	_remove_single_player()
	
func _add_player_to_game(id : int):
	print("Made Player with ID: %s" % id)
	
	var player_to_add = multiplayer_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	_players_spawn_node.add_child(player_to_add, true)

func _remove_player_from_game(id : int):
	print("Removing Player with ID: %s" % id)
	if not _players_spawn_node.has_node(str(id)):
		return
	_players_spawn_node.get_node(str(id)).queue_free()
	
func _remove_single_player():
	print("Removing Default Player")
	var player_to_remove = get_tree().get_current_scene().get_node("Player")
	player_to_remove.queue_free()
