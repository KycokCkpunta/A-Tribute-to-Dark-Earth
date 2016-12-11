extends Node2D

onready var ground = get_node("ground")
onready var walls = get_node("walls")
onready var roof = get_node("roof")
onready var fade = get_node("fade")

var type = 0
var init = false
var x 
var y
var radius
var i 


func _ready():
	ground.clear()
	walls.clear()
	roof.clear()
	fade.clear()
	loadworld("menu")
	randomize()
	
func loadworld(location):
	var f = File.new()
	f.open("res://locations/"+location, File.READ)
	var content = f.get_var()
	f.close()
	for tile in content:
		ground.set_cell(tile.x,tile.y,randi()%4,randi()%2,randi()%2,randi()%2)
	set_roof()
	
func set_roof():
	var cells = ground.get_used_cells()
	var y_t = cells[0].y-5
	var y_b = cells[cells.size()-1].y+5
	cells.sort()
	var x_l = cells[0].x-5
	var x_r = cells[cells.size()-1].x+5
	for i in range(x_l-5,x_r+5):
		for j in range(y_t-5,y_b+5):
			if ground.get_cell(i,j) != -1:
				if ground.get_cell(i,j-1) == -1:
					walls.set_cell(i,j,0)
					roof.set_cell(i,j-1,0)
				if ground.get_cell(i,j+1) == -1:
					roof.set_cell(i,j+1,0)
				if ground.get_cell(i+1,j) == -1:
					roof.set_cell(i+1,j,0)
				if ground.get_cell(i-1,j) == -1:
					roof.set_cell(i-1,j,0)
	for i in range(x_l-5,x_r+5):
		for j in range(y_t-5,y_b+5):
			if roof.get_cell(i,j) == -1 and ground.get_cell(i,j) == -1:
				if (ground.get_cell(i+2,j) != -1 or
				ground.get_cell(i-2,j) != -1 or
				ground.get_cell(i,j+2) != -1 or
				ground.get_cell(i,j-2) != -1 or
				ground.get_cell(i+2,j+2) != -1 or
				ground.get_cell(i+2,j-2) != -1 or
				ground.get_cell(i-2,j+2) != -1 or
				ground.get_cell(i-2,j-2) != -1):
					roof.set_cell(i,j,0)
	for i in range(x_l-5,x_r+5):
		for j in range(y_t-5,y_b+5):
			if roof.get_cell(i,j) == -1 and ground.get_cell(i,j) == -1:
				if (roof.get_cell(i+1,j) != -1 or
				roof.get_cell(i-1,j) != -1 or
				roof.get_cell(i,j+1) != -1 or
				roof.get_cell(i,j-1) != -1):
					fade.set_cell(i,j,0)
				
func gen(t):
	if t == 1: #dungeon1
		if init == false:
			radius = 0.8
			x = 0
			y = 0
			i = 0
			init = true
		if i < 2048:
			for q in range(128):
				var dir = randi()%4
				if dir == 0:
					x+=1
				elif dir == 1:
					x-=1
				elif dir == 2:
					y+=1
				elif dir == 3:
					y-=1
				
				var f = 1 - radius
				var ddf_x = 1
				var ddf_y = -2 * radius
				var x_circle = 0
				var y_circle = radius
				ground.set_cell(x, y + radius,randi()%4,randi()%2,randi()%2,randi()%2)
				ground.set_cell(x, y - radius,randi()%4,randi()%2,randi()%2,randi()%2)
				ground.set_cell(x + radius, y,randi()%4,randi()%2,randi()%2,randi()%2)
				ground.set_cell(x - radius, y,randi()%4,randi()%2,randi()%2,randi()%2)
				while x_circle < y_circle:
					if f >= 0: 
						y_circle -= 1
						ddf_y += 2
						f += ddf_y
						x_circle += 1
						ddf_x += 2
						f += ddf_x    
						ground.set_cell(x + x_circle, y + y_circle,randi()%4,randi()%2,randi()%2,randi()%2)
						ground.set_cell(x - x_circle, y + y_circle,randi()%4,randi()%2,randi()%2,randi()%2)
						ground.set_cell(x + x_circle, y - y_circle,randi()%4,randi()%2,randi()%2,randi()%2)
						ground.set_cell(x - x_circle, y - y_circle,randi()%4,randi()%2,randi()%2,randi()%2)
						ground.set_cell(x + y_circle, y + x_circle,randi()%4,randi()%2,randi()%2,randi()%2)
						ground.set_cell(x - y_circle, y + x_circle,randi()%4,randi()%2,randi()%2,randi()%2)
						ground.set_cell(x + y_circle, y - x_circle,randi()%4,randi()%2,randi()%2,randi()%2)
						ground.set_cell(x - y_circle, y - x_circle,randi()%4,randi()%2,randi()%2,randi()%2)
				
				i = ground.get_used_cells().size()
		