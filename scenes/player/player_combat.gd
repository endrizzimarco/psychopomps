extends KinematicBody2D

onready var fsm = FSM.new(self, $states, $states/idle, true)

var anim_cur = ""
var anim_nxt = "idle"

enum Position {LEFT=700, CENTER=1250, RIGHT=1800}
var pos_cur = Position.CENTER
var dash_dir : String
var same_frame_flag : bool = false
var jumped_mid_dash : bool = false

export var health = 6
var is_invulnerable := false
var invulnerable_timer := 0.0

onready var animations = $animations


func _ready():
	$states/dead/AudioStreamPlayer2.play()
#	cur_params = parameters[gamestate.state.current_player_status
#	game.player = self
#	var _ret = gamestate.connect( "gamestate_changed", self, "set_attack_reach", [], Object.CONNECT_DEFERRED )
	pass


func _exit_tree():
	fsm.free()


func _physics_process(delta):
	fsm.run_machine(delta)
	
	if anim_cur != anim_nxt:
		anim_cur = anim_nxt
		$animations.play(anim_cur)
	
	if is_invulnerable:
		invulnerable_timer -= delta
		if invulnerable_timer <= 0:
			is_invulnerable = false


func can_dodge() -> bool:
	if self.pos_cur == self.Position.LEFT and \
	   self.dash_dir == "left":
		return false
	if self.pos_cur == self.Position.RIGHT and \
	   self.dash_dir == "right":
		return false
	return true


func _on_hurtbox_area_entered(_area):
	if not is_invulnerable and _area.name == "hitbox":
		health -= 1
		_update_hearts()
		if $animations.current_animation == "idle":
			$animations.play("hit")
			$animations.queue("idle")
		$states/hit/fx.play("hit")
		$states/hit/AudioStreamPlayer.play() 
		is_invulnerable = true
		invulnerable_timer = 0.3

		
func _update_hearts():
	match health:
		0:
			$energy/heart_1.set_frame(2)
			$energy/heart_2.set_frame(2)
			$energy/heart_3.set_frame(2)
			fsm.state_nxt = fsm.states.dead
		1:
			$energy/heart_1.set_frame(1)
			$energy/heart_2.set_frame(2)
			$energy/heart_3.set_frame(2)
		2:
			$energy/heart_1.set_frame(0)
			$energy/heart_2.set_frame(2)
			$energy/heart_3.set_frame(2)
		3:
			$energy/heart_1.set_frame(0)
			$energy/heart_2.set_frame(1)
			$energy/heart_3.set_frame(2)
		4:
			$energy/heart_1.set_frame(0)
			$energy/heart_2.set_frame(0)
			$energy/heart_3.set_frame(2)
		5:
			$energy/heart_1.set_frame(0)
			$energy/heart_2.set_frame(0)
			$energy/heart_3.set_frame(1)
		6:
			$energy/heart_1.set_frame(0)
			$energy/heart_2.set_frame(0)
			$energy/heart_3.set_frame(0)
