extends Node2D

const FIRST_SCN = "res://scenes/Fake RPG intro/Fake_RPG_world.tscn"
const MENU_SCN = "res://screens/start_menu/start_menu.tscn"



func _ready():
#	game.main = self
#	if game.debug:
#		load_gamestate()
#	else:
	load_screen( FIRST_SCN )
	
		
#	var _ret = gamestate.connect( "gamestate_changed", self, "_on_gamestate_change" )

func _input(event):
	if event.is_action_pressed( "btn_quit" ) or \
		event.is_action_pressed( "btn_enter" ):
			pause_game()

#==================================
# Load Screen
#==================================
var load_state = 0
var cur_screen
func load_screen( scrn := "" ):
	if not scrn.empty():
		load_state = 0
		cur_screen = scrn
	match load_state:
		0:
			print( "LOADING SCREEN: ", cur_screen )
			get_tree().paused = true
#			$fade_layer/fadeanim.play( "fade_out" )
			load_state = 1
			$screentimer.set_wait_time( 0.2 )
			$screentimer.start()
		1:
#			$hud_layer/hud.hide()
			var children = $levels.get_children()
			if not children.empty():
				children[0].queue_free()
			load_state = 2
			$screentimer.set_wait_time( 0.05 )
			$screentimer.start()
		2:
			var new_level = load( cur_screen ).instance()
			$levels.add_child( new_level )
			load_state = 3
			$screentimer.set_wait_time( 0.3 )
			$screentimer.start()
		3:
#			$fade_layer/fadeanim.play( "fade_in" )
			load_state = 4
			$screentimer.set_wait_time( 0.2 )
			$screentimer.start()
		4:
			get_tree().paused = false
			load_state = 0

func pause_game():
	get_tree().paused = true
	$pause_layer/pause_menu.show()
	$pause_layer/pause_menu.activate()


func _on_pause_menu_pause_finished( cont ):
	print(cont)
	$pause_layer/pause_menu.deactivate()
	yield( get_tree().create_timer( 0.02 ), "timeout" )
	
	$pause_layer/pause_menu.hide()

	get_tree().paused = false
	
	if not cont:
		print('exiting')
#		load_screen( MENU_SCN )




func _on_screentimer_timeout():
	load_screen()
