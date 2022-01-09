extends Node2D

var rng = RandomNumberGenerator.new()
var side = ''

# https://godotengine.org/qa/4786/how-to-pass-parameters-when-instantiating-a-node
func init(curr_side):
	side = curr_side 


# Play a random arm_atk based on which side the boss currently is
func _ready():
	rng.randomize()
	var anim_name = side + '_' + str(rng.randi_range(0, 1))
	$anim.play(anim_name)


# Remove scene after animation plays
func _process(_delta):
	if not $anim.current_animation:
		queue_free()
