extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$atk_anim.play("arm_atk")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _spike_attack():
	var spike = preload("res://scenes/bosses/boss_1/phase_1/attacks/spike_atk.tscn").instance()
	add_child(spike)


func _arm_attack():
	var arm_atk = preload("res://scenes/bosses/boss_1/phase_1/attacks/arm_atk.tscn").instance()
	add_child(arm_atk)
