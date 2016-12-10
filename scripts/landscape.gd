extends Node2D

func _ready():
	randomize()
	for i in range(-64,64):
		for j in range(-64,64):
			get_node("TileMap").set_cell(i,j,0,randi()%2,randi()%2,randi()%2)