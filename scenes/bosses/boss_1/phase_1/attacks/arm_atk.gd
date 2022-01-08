extends Node2D


var rng = RandomNumberGenerator.new()

# Play a random arm_atk
func _ready():
	rng.randomize()
	var randint = rng.randi_range(0, 3)
	$anim.play(str(randint))


# Remove scene after animation plays
func _process(_delta):
	if not $anim.current_animation:
		queue_free()

