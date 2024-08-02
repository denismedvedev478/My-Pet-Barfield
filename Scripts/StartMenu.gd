extends Control


signal play_button_pressed_loader_signal;
# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer.position.x = 170
	$CenterContainer.position.y = 290
	print("ПОСМОТРИТЕ НА МЕНЯ Я БЫЛ ВЫЗВАН %s" % get_parent())
	Player.visible = false;

func _on_play_button_pressed():
	print("StartMenu._on_play_button_pressed")
	$AnimationPlayer.play("Exit Start Menu");
	await 	$AnimationPlayer.animation_finished;
	get_tree().paused = false;
	play_button_pressed_loader_signal.emit()
	
	# resetting the state
	show_behind_parent = true;
	top_level = false;
	process_mode = Node.PROCESS_MODE_DISABLED;
	process_priority = 0
	queue_free();


func _on_quit_button_pressed():
	Main.notification(NOTIFICATION_WM_CLOSE_REQUEST)
