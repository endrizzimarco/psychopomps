extends Node

export var boss_health = 200
var curr_side = "right"
# Called when the node enters the scene tree for the first time.


func _ready():
	$atk_master.play("pattern_1")
	
	
func _process(delta):
	print(boss_health)
	if boss_health <= 0:
		$AudioStreamPlayer.play()
		$Sprite.show()
		$boss.queue_free()
		
		

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


func _rain_attack():
	var rain_atk = preload("res://scenes/bosses/boss_1/phase_1/attacks/rain_atk.tscn").instance()
	add_child(rain_atk)


func _change_side():
	if curr_side == "right":
		curr_side = "left"
		$atk_anim.play("change_side")
	else:
		curr_side = "right"
		$atk_anim.play_backwards("change_side")


func _on_hurtbox_area_entered(area):
	match area.name:
		"light_atk":
			boss_health -= 1
			$boss/fx.play("hit")
		"heavy_atk":
			boss_health -= 7
			$boss/fx.play("hit")
