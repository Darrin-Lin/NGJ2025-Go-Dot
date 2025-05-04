extends RigidBody2D

const MAX_CHARGE = 2.0       # max charge time
const CHARGE_RATE = 1.5      # charge rate/sec
const RELEASE_FORCE = 3000   # force applied when released
const LEFT_BOUND = -600
const RIGHT_BOUND = 600
const RADIUS = 30
var charge_left := 0.0
var charge_right := 0.0
var max_score = 0

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var circle_shape: CircleShape2D = CircleShape2D.new()

func _ready() -> void:
	circle_shape.radius = RADIUS  
	collision_shape.shape = circle_shape 

func _draw() -> void:
	draw_circle(Vector2.ZERO, RADIUS, Color.DEEP_SKY_BLUE)
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if Input.is_action_pressed("ui_left"):
		charge_left = min(charge_left + CHARGE_RATE * state.step, MAX_CHARGE)

	if Input.is_action_pressed("ui_right"):
		charge_right = min(charge_right + CHARGE_RATE * state.step, MAX_CHARGE)
	
	if (Input.is_action_just_released("ui_right") != Input.is_action_just_released("ui_left")) and (charge_right > 0.0 || charge_left > 0.0):
		var force = (charge_right - charge_left) * RELEASE_FORCE 
		state.apply_central_impulse(Vector2(force, 0))
		charge_right = 0.0
		charge_left = 0.0 
	if Input.is_action_just_released("ui_right"):
		charge_right = 0.0
	if Input.is_action_just_released("ui_left"):
		charge_left = 0.0
	# reflect the player when it hits the left or right bounds
	if global_position.x < LEFT_BOUND:
		global_position.x = LEFT_BOUND
		state.linear_velocity.x *= -1
	elif global_position.x > RIGHT_BOUND:
		global_position.x = RIGHT_BOUND
		state.linear_velocity.x *= -1
	
	if (-global_position.y + 512) > max_score:
		max_score = (-global_position.y + 512)
		if max_score > Global.high_score:
			Global.high_score = max_score
	if global_position.y > 2024:
		Global.round_score = max_score
		call_deferred("change_scene")
	if Input.is_action_just_pressed("ui_cancel"):
		Global.round_score = 0
		call_deferred("change_scene")

			
func change_scene():
	get_tree().change_scene_to_file("res://gameover.tscn")
