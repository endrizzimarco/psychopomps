extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var anim = $anim.get_animation("all_random")
	# Add either low or high animations for each tongue attack
	anim.track_set_key_value(0, 0, _tongue_left(rng.randi_range(0, 1)))
	anim.track_set_key_value(1, 0, _tongue_center(rng.randi_range(0, 1)))
	anim.track_set_key_value(2, 0, _tongue_right(rng.randi_range(0, 1)))
	$anim.play("all_random") # Master animation
	
	
# Delete instance when master animation finishes
func _process(_delta):
	if not $anim.current_animation:
		queue_free()


func _tongue_left(atk):
	$tongue_left/anim.play(str(atk))


func _tongue_center(atk):
	$tongue_center/anim.play(str(atk))


func _tongue_right(atk):
	$tongue_right/anim.play(str(atk))

