extends Node2D

const PLATFORM_WIDTH = 800
const PLATFORM_HEIGHT = 40
const PLATFORM_LAYERS = 5
const LAYER_SPACING = 300  # the distance between each layer
const PLATFORM_MIDPOINT = 0
const GENERATE_THRESHOLD = 100  # the distance from the player to generate new platforms

@onready var player = get_node("../Player")
var current_max_y = 900  # maximum y position for the platforms

func _ready():
	randomize()

func _process(_delta):
	while player.global_position.y < current_max_y + GENERATE_THRESHOLD:
		current_max_y -= LAYER_SPACING
		spawn_platform_at(current_max_y)

func spawn_platform_at(y_offset: float):
	var half_width = randf_range(PLATFORM_WIDTH / 10.0, PLATFORM_WIDTH / 2.0)
	var x_shift = randf_range(-300, 300)
	var start = Vector2(PLATFORM_MIDPOINT + x_shift - half_width, y_offset)
	var end = Vector2(PLATFORM_MIDPOINT + x_shift + half_width, y_offset)
	var control = Vector2((start.x + end.x) / 2, y_offset + 150)

	create_bezier_platform(start, control, end, PLATFORM_HEIGHT)

func create_bezier_platform(start: Vector2, control: Vector2, end: Vector2, height: float):
	var points = []
	for i in range(0, 100):
		var t = i / 99.0
		var p = (1 - t) * (1 - t) * start + 2 * (1 - t) * t * control + t * t * end
		points.append(p)

	var platform_shape = points.duplicate()
	for i in range(points.size() - 1, -1, -1):
		platform_shape.append(points[i] + Vector2(0, height))

	var platform = StaticBody2D.new()
	var col = CollisionPolygon2D.new()
	col.polygon = platform_shape
	platform.add_child(col)
	add_child(platform)

	var line = Line2D.new()
	line.points = points
	line.width = 4
	line.default_color = Color.SKY_BLUE
	add_child(line)
