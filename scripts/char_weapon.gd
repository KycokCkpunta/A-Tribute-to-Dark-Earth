extends Node2D

onready var bullet1 = preload("res://scn/misc/bullet1.tscn")
onready var cur_weapon = get_node("cur_weapon")
onready var camera = get_node("../Camera2D")

func _ready():
	set_process(true)

func _process(delta):
	var mousepos = get_viewport().get_mouse_pos()-get_viewport_rect().size/2+camera.get_camera_pos()
	cur_weapon.look_at(mousepos)
	if Input.is_action_just_pressed("shoot"):
		var b = bullet1.instance()
		get_tree().get_root().add_child(b)
		b.set_pos(cur_weapon.get_node("st").get_global_pos())
		b.look_at(mousepos)
		b.start()
