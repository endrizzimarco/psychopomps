extends CanvasLayer

onready var textbox_container = $TextboxContainer
onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/start
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/end
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/label

const read_rate = 0.01

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY

var text_queue = []

func _ready():
	hide_textbox()
	queue_text("hai ho hai ho!")
	queue_text("and a bottle of rum")
	queue_text("this is fun, this is fun, this is fun!")
	


func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("btn_light_atk"):
				change_state(State.FINISHED)
				label.percent_visible = 1.0
				$Tween.stop_all()
				end_symbol.text = "v"
		State.FINISHED:
			if Input.is_action_just_pressed("btn_light_atk"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	
	textbox_container.hide()
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	change_state(State.READING)
	label.text = next_text
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * read_rate, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_all_completed():
	end_symbol.text = "v"
	change_state(State.FINISHED)
	
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("changing state to READY")
		State.READING:
			print("changing state to READING")
		State.FINISHED:
			print("changing state to FINISHED")
