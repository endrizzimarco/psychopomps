extends FSM_State

onready var anim = $"../../animations"

func initialize() -> void:
	if obj.anim_cur == "idle":
		obj.anim_nxt = "crouch"

func run( _delta ) -> void:
	if not anim.current_animation: 
		obj.anim_nxt = "crouch_idle"

	if Input.is_action_just_pressed("btn_right") or \
		Input.is_action_just_pressed("btn_left"):
		obj.dash_dir = "right" if Input.is_action_just_pressed("btn_right") else "left"
		
		if obj.can_dodge():
			fsm.state_nxt = fsm.states.dodge

	if not Input.is_action_pressed("btn_down"):
		fsm.state_nxt = fsm.states.idle
