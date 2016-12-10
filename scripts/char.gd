extends KinematicBody2D
onready var anim = get_node("anim")
onready var tex = get_node("tex")

var cur_anim = "idle"
var new_anim = "idle"

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var vec = Vector2()
	
	if Input.is_action_pressed("up"):
		vec+=Vector2(0,-1)
	if Input.is_action_pressed("down"):
		vec+=Vector2(0,1)
	if Input.is_action_pressed("left"):
		vec+=Vector2(-1,0)
	if Input.is_action_pressed("right"):
		vec+=Vector2(1,0)
		
	vec = vec.normalized()*64*delta
	if vec == Vector2(0,0):
		new_anim = "idle"
	else:
		new_anim = "walk"
	
	move(vec)
	
	anim()
	look()

func anim():
	if cur_anim != new_anim:
		cur_anim = new_anim
		anim.play(cur_anim)
	
func look():
	if get_viewport().get_mouse_pos().x > get_viewport_rect().size.x/2:
		tex.set_scale(Vector2(1,1))
	elif get_viewport().get_mouse_pos().x < get_viewport_rect().size.x/2:
		tex.set_scale(Vector2(-1,1))
	if get_viewport().get_mouse_pos().y < get_viewport_rect().size.y/2:
		tex.get_node("weapon").set_z(-2)
	elif get_viewport().get_mouse_pos().y > get_viewport_rect().size.y/2:
		tex.get_node("weapon").set_z(0)
	tex.get_node("weapon").look_at(get_viewport().get_mouse_pos()-get_viewport_rect().size/2+get_node("Camera2D").get_camera_pos())