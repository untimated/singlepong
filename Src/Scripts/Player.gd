extends KinematicBody2D

var MOVEMENT_STATE = {
	"LEFT" : false,
	"RIGHT" : false,
	"IDLE": true,
	}
var CONTROL_STATE = {
	"A": false,
	"D": false,
	}

var speed = 4.0
var velocity = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_A or CONTROL_STATE.A:
			CONTROL_STATE.A = true
			print("control : ", CONTROL_STATE)
		if event.scancode == KEY_D or CONTROL_STATE.D:
			CONTROL_STATE.D = true
			print("control : ", CONTROL_STATE)
	if event is InputEventKey and not event.pressed:
		if event.scancode == KEY_A:
			CONTROL_STATE.A = false
		if event.scancode == KEY_D:
			CONTROL_STATE.D = false

	if ( CONTROL_STATE.A and CONTROL_STATE.D ) or \
		( not CONTROL_STATE.A and not CONTROL_STATE.D ):
		MOVEMENT_STATE = {"LEFT":false, "RIGHT": false, "IDLE": true}
	if CONTROL_STATE.A :
		MOVEMENT_STATE = {"LEFT":true, "RIGHT": false, "IDLE": false}
	elif CONTROL_STATE.D:
		MOVEMENT_STATE = {"LEFT":false, "RIGHT": true, "IDLE": false}

	pass

func process_movement() -> Vector2:
	if MOVEMENT_STATE.LEFT:
		velocity.x = -speed
	elif MOVEMENT_STATE.RIGHT:
		velocity.x = speed
	elif MOVEMENT_STATE.IDLE:
		velocity = Vector2(0.0, 0.0)

	return velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var v: Vector2 = process_movement()
	var collision = self.move_and_collide(v)
	pass



