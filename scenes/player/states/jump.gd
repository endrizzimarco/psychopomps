extends FSM_State


func initialize() -> void:
	obj.anim_nxt = "jump"

func run( _delta ) -> void:	
	if Input.is_action_just_pressed("btn_right") or \
		Input.is_action_just_pressed("btn_left"):
		obj.dash_dir = "right" if Input.is_action_just_pressed("btn_right") else "left"
		var pos_cur = obj.pos_cur
		var pos_nxt
		if Input.is_action_just_pressed("btn_right"):
			pos_nxt = obj.Position.RIGHT if obj.pos_cur == obj.Position.CENTER else obj.Position.CENTER
		else: 
			pos_nxt = obj.Position.LEFT if obj.pos_cur == obj.Position.CENTER else obj.Position.CENTER
		
		if obj.can_dodge():
			_airdash(pos_cur, pos_nxt)
	
	# If no animations are playing, player has finished jumping and can go back to idle
	if not $'../../animations'.current_animation:
		fsm.state_nxt = fsm.states.idle

# Use the dodge Tween to dash in the air
func _airdash(pos_cur, pos_nxt):
	obj.pos_cur = pos_nxt
	$'../dodge/Tween'.interpolate_property(obj, "position:x", pos_cur, pos_nxt, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$'../dodge/Tween'.start()
