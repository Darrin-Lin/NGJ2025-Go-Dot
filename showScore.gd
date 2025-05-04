extends Label
func _process(delta):
	self.text = "Highest Score: %d\nScore: %d" % [Global.high_score, Global.round_score]
	self.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	self.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	self.anchor_left = 0.5
	self.anchor_right = 0.5
	self.anchor_top = 0.5
	self.anchor_bottom = 0.5

	self.offset_left = -self.size.x / 2
	self.offset_top = -self.size.y / 2
