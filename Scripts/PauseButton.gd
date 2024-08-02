extends Button

func _ready():
	connect("button_down", Main.open_pause_menu);

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		button_down.emit();
	
