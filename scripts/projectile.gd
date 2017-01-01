extends Sprite

func start():
	set_fixed_process(true)
	
func _fixed_process(delta):
	set_pos(get_pos().linear_interpolate(get_node("ft").get_global_pos(),delta*300))


func _on_Area2D_body_enter( body ):
	if body.get_name() != "???":
		set_z(-25)
		set_fixed_process(false)
		get_node("Particles2D").set_emitting(true)
		
		get_node("Timer").start()
		
		
		


func _on_Timer_timeout():
	queue_free()
