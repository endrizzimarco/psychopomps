extends FSM_State

func initialize() -> void:
	var	pos_cur = obj.pos_cur
	var pos_nxt

	if obj.dash_dir == "left":
		# Set new player position, either left or center
		obj.pos_cur = obj.Position.LEFT if obj.pos_cur == obj.Position.CENTER else obj.Position.CENTER
		# Set animation to either crouch dash or standing dash
		obj.anim_nxt = "crouch_dash_left" if Input.is_action_pressed("btn_down") else "dash_left"
	elif obj.dash_dir == "right":
		obj.pos_cur = obj.Position.RIGHT if obj.pos_cur == obj.Position.CENTER else obj.Position.CENTER
		obj.anim_nxt = "crouch_dash_right" if Input.is_action_pressed("btn_down") else "dash_right"

	pos_nxt = obj.pos_cur
	$Tween.interpolate_property(obj, "position:x", pos_cur, pos_nxt, 0.08, Tween.TRANS_LINEAR)
	$Tween.start()


func run(_delta) -> void:
	# When finished dashing, set state back to idle/crouch-idle
	if not $Tween.is_active():
		if obj.jumped_mid_dash: 
			fsm.state_nxt = fsm.states.jump
			return

		if Input.is_action_pressed("btn_down"):
			fsm.state_nxt = fsm.states.crouch
		else:
			fsm.state_nxt = fsm.states.idle

	# If dash pressed mid-dash, re-initialize state
	if Input.is_action_just_pressed("btn_right") or \
		Input.is_action_just_pressed("btn_left"):
		obj.dash_dir = "right" if Input.is_action_just_pressed("btn_right") else "left"
	
		if obj.can_dodge():
			self.initialize()
	
	# If jump pressed mid-dash 
	if Input.is_action_just_pressed("btn_up"):
		obj.jumped_mid_dash = true

