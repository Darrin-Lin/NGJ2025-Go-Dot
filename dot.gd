extends Node2D

var radius = 1 * Global.size_base
var circle_color = Color(0.5, 0.5, 0.5)
var click_count = 0
# move dot to the center of the screen
func _ready():
	position = get_viewport().get_size() / 2
	click_count = 0
func _draw():
	draw_circle(Vector2.ZERO, radius, circle_color)
	
func _input(event):
	# let the dot follow the mouse
	if event is InputEventMouseMotion:
		position += event.relative
		position = Global.check_point(position)
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_local_mouse_position()
		if mouse_pos.length() < radius:
			click_count += 1
			if click_count < 5:
				circle_color.g += 0.1
				# update the color of the dot
				queue_redraw()
			else:
				get_tree().change_scene_to_file("res://stage.tscn")
