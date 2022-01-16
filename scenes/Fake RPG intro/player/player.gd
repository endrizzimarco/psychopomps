extends KinematicBody2D

export var speed = 400

enum State {
	IDLE
	WALKING
	TALKING
}

var current_state = State.IDLE
var current_animation = "idle"
var dir

func _physics_process(delta):
	match current_state:
		State.WALKING:
			check_interaction()
			var moving = move()
			if moving:
				$anim.current_animation = current_animation + str(dir)
			else:
				current_state = State.IDLE

		State.IDLE: 
			check_interaction()
			$anim.stop()
			if _dir_input_pressed(): 
				current_state = State.WALKING
			
		State.TALKING:
			$anim.stop()


func check_interaction():
	if Input.is_action_just_pressed("btn_light_atk"):
		$"interact/collision".disabled = false
	else:
		$"interact/collision".disabled = true

func move():
	var input_dir = Vector2.ZERO

	if Input.is_action_pressed("btn_right"):
		input_dir.x += 1
	if Input.is_action_pressed("btn_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("btn_down"):
		input_dir.y += 1
	if Input.is_action_pressed("btn_up"):
		input_dir.y -= 1
	input_dir = input_dir.normalized()
	if input_dir.length() != 0:
		dir = input_dir.angle() / (PI/4)
		dir = wrapi(int(dir), 0, 8)
		current_animation = "walk_"
		
	move_and_slide(input_dir * speed)
	return input_dir

func _dir_input_pressed(): 
	if Input.is_action_pressed("btn_right") or Input.is_action_pressed("btn_left") or \
		Input.is_action_pressed("btn_up") or Input.is_action_pressed("btn_down"):
		return true
	return false


func _on_textbox_start():
	print('heyy')
