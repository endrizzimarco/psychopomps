extends Node

var curr_side = "right"
# Called when the node enters the scene tree for the first time.
func _ready():
	$atk_master.play("pattern_1")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _spike_attack():
	var spike = preload("res://scenes/bosses/boss_1/phase_1/attacks/spike_atk.tscn").instance()
	add_child(spike)


func _arm_attack():
	var arm_atk = preload("res://scenes/bosses/boss_1/phase_1/attacks/arm_atk.tscn").instance()
	arm_atk.init(curr_side)
	add_child(arm_atk)


func _tongue_attack():
	var tongue_atk = preload("res://scenes/bosses/boss_1/phase_1/attacks/tongue_atk.tscn").instance()
	add_child(tongue_atk)

func _change_side():
	if curr_side == "right":
		curr_side = "left"
		$atk_anim.play("change_side")
	else:
		curr_side = "right"
		$atk_anim.play_backwards("change_side")
