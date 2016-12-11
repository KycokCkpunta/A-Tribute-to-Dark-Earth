extends Sprite

func start():
	set_fixed_process(true)
	
func _fixed_process(delta):
	set_pos(get_node("ft").get_global_pos())


func _on_Area2D_body_enter( body ):
	print(body)
