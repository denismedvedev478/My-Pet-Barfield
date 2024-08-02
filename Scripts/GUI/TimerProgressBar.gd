extends ProgressBar


@onready var player_timer:Timer = Player.get_child(0)

func _process(delta):
	call_deferred_thread_group("set_value", player_timer.time_left)
