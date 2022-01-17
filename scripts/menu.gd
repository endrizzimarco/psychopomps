extends Node2D
class_name SimpleMenu

signal selected_item( item_no )



export var is_active = false
export var SELECTED_ITEM_OPACITY = 1.0
export var UNSELECTED_ITEM_OPACITY = 0.3
export var UNSELECTABLE_ITEM_OPACITY = 0.1

var items = []
var unselectable_items = []
var cur_item = 0



func _ready():
	if not is_active:
#		set_process_input( false )
		set_physics_process( false )
	update_menu()


func update_menu():
	items = []
	unselectable_items = []
	for c in get_children():
		if c is SimpleMenuItem:
			items.append( c )
			if c.selectable:
				c.modulate.a = UNSELECTED_ITEM_OPACITY
			else:
				c.modulate.a = UNSELECTABLE_ITEM_OPACITY
				unselectable_items.append( c )
	items[cur_item].modulate.a = SELECTED_ITEM_OPACITY

func activate():
	is_active = true
#	set_process_input( true )
	set_physics_process( true )
	cur_item = 0
	set_item()

func deactivate():
	is_active = false
#	set_process_input( false )
	set_physics_process( false )


# THIS ONLY WORKS FOR A SINGLE UNSELECTABLE ITEM!
func _physics_process(_delta):
	if Input.is_action_just_pressed( "btn_down" ) or \
		Input.is_action_just_pressed( "btn_right" ):
			cur_item += 1
			if cur_item >= items.size(): cur_item -= items.size()
			if unselectable_items.find( items[cur_item] ) != -1:
				cur_item += 1
				if cur_item >= items.size(): cur_item -= items.size()
			set_item()
	if Input.is_action_just_pressed( "btn_up" ) or \
		Input.is_action_just_pressed( "btn_left" ):
			cur_item -= 1
			if cur_item < 0: cur_item += items.size()
			if unselectable_items.find( items[cur_item] ) != -1:
				cur_item -= 1
				if cur_item < 0: cur_item += items.size()
			set_item()
	if Input.is_action_just_pressed( "btn_light_atk" ) or \
		Input.is_action_just_pressed( "btn_enter" ):
			emit_signal( "selected_item", cur_item )

#func _input( evt ):
#	if evt.is_action_pressed( "btn_down" )or \
#			evt.is_action_pressed( "btn_right" ):
#		cur_item += 1
#		if cur_item >= items.size(): cur_item -= items.size()
#		if unselectable_items.find( items[cur_item] ) != -1:
#			cur_item += 1
#			if cur_item >= items.size(): cur_item -= items.size()
#		set_item()
#	if evt.is_action_pressed( "btn_up" ) or \
#			evt.is_action_pressed( "btn_left" ):
#		cur_item -= 1
#		if cur_item < 0: cur_item += items.size()
#		if unselectable_items.find( items[cur_item] ) != -1:
#			cur_item -= 1
#			if cur_item < 0: cur_item += items.size()
#		set_item()
#	if evt.is_action_pressed( "btn_jump" ) or evt.is_action_pressed( "btn_fire" ):
#		emit_signal( "selected_item", cur_item )

func set_item():
	for idx in range( items.size() ):
		if cur_item == idx:
			items[idx].modulate.a = SELECTED_ITEM_OPACITY
		else:
			if unselectable_items.find( items[idx] ) == -1:
				items[idx].modulate.a = UNSELECTED_ITEM_OPACITY


