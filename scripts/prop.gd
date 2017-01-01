extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	for node in get_children():
		