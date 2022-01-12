extends KinematicBody2D

const acceleration = 1500
const speed = 600
const friction = 5000

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("btn_right") - Input.get_action_strength("btn_left")
	input_vector.y = Input.get_action_strength("btn_down") - Input.get_action_strength("btn_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(speed)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("btn_light_atk"):
		$"Position2D/Interaction component/CollisionShape2D".disabled = false
	else:
		$"Position2D/Interaction component/CollisionShape2D".disabled = true
	
	if Input.is_action_just_pressed("btn_right"):
		$Position2D.rotation_degrees = 180
	elif Input.is_action_just_pressed("btn_left"):
		$Position2D.rotation_degrees = 0
	elif Input.is_action_just_pressed("btn_up"):
		$Position2D.rotation_degrees = 90
	elif Input.is_action_just_pressed("btn_down"):
		$Position2D.rotation_degrees = -90
		
		
		
		
