extends KinematicBody2D


const WINDOW_WIDTH = OS.window_size.x
const WINDOW_HEIGHT = OS.window_size.y 
const LEFT_WALL_NORMAL = Vector2(1, 0)
const RIGHT_WALL_NORMAL = Vector2(-1, 0)
const TOP_WALL_NORMAL = Vector2(0, -1)
const BOTTOM_WALL_NORMAL = Vector2(0, 1)


var direction = Vector2(-1, 0.5)
var player_normal = Vector2(0,-1)
var speed = 5

onready var offset = get_node('Sprite').get_rect().size.x / 2

# Called when the node enters the scene tree for the first time.
func _ready():
	# print('Ball Width', ball_width)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var result = boundary_check(self.position)
	direction = result.dir.normalized() * speed
	var collision = self.move_and_collide(direction)
	if collision : 
		var collider = collision.collider
		var collider_shape = collision.collider_shape_index
		print('collision : ', collision)
		print('collider : ', collider.name)
		print('collider shape : ', collision.collider_shape_index)
		if collider.name == 'Player':
			match collider_shape:
				0 :	direction = direction.bounce(collision.normal)
				1 :	direction = -direction
				2 :	direction = -direction
			# print("normal : ", collision.normal)
			print("dir now : ", direction)
	pass

func process_movement() -> Vector2:
	return Vector2()

func boundary_check(pos: Vector2) -> Object: 
	var resp = {"dir": Vector2(), "msg": ""} 
	if pos.x + offset > WINDOW_WIDTH : 
		self.position.x = WINDOW_WIDTH - offset 
		resp.dir = direction.bounce(RIGHT_WALL_NORMAL)
		resp.msg = "right boundary " + str(resp.dir)
	elif pos.x - offset < 0.0:
		print(pos)
		self.position.x = 0.0 + offset
		resp.dir = direction.bounce(LEFT_WALL_NORMAL)
		resp.msg = "left boundary " + str(resp.dir)
	elif pos.y + offset > WINDOW_HEIGHT:
		self.position.y = WINDOW_HEIGHT - offset 
		resp.dir = direction.bounce(BOTTOM_WALL_NORMAL)
		resp.msg = "bottom boundary " + str(resp.dir)
	elif pos.y - offset < 0.0:
		self.position.y = 0.0 + offset
		resp.dir = direction.bounce(TOP_WALL_NORMAL)
		resp.msg = "top boundary " + str(resp.dir)
	else:
		resp.dir = direction
	return resp
