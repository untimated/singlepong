extends KinematicBody2D


const WINDOW_WIDTH = OS.window_size.x
const WINDOW_HEIGHT = OS.window_size.y 

var direction = Vector2(-1, 0)
var player_normal = Vector2(0,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.move_and_collide(direction)
	print(boundary_check(self.position))
	pass

func process_movement() -> Vector2:
	return Vector2()

func boundary_check(pos: Vector2): 
	var msg = '';
	if pos.x > WINDOW_WIDTH : 
		msg = "right boundary"
	elif pos.x < 0:
		msg = "left boundary"
	elif pos.y > WINDOW_HEIGHT:
		msg = "bottom boundary"
	elif pos.y < 0:
		msg = "top boundary"

	return msg
