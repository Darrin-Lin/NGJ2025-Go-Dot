extends Node
var size_base = 32
func check_point(point):
	if point.x < -get_viewport().get_size().x/2:
		point.x = -get_viewport().get_size().x/2
	elif point.x > get_viewport().get_size().x/2:
		point.x = get_viewport().get_size().x/2
	if point.y < -get_viewport().get_size().y/2:
		point.y = -get_viewport().get_size().y/2
	elif point.y > get_viewport().get_size().y/2:
		point.y = get_viewport().get_size().y/2
	return point
var high_score = 0
var round_score = 0
