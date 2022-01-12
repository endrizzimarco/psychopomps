extends KinematicBody2D

const acceleration = 1200
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
