extends ProgressBar

func _ready():
	Player.health_changed.connect(change_value)
	value = 100 * Player.player_status.health/Player.max_value
	
func change_value(amount):
	value = 100 * Player.player_status.health/Player.max_value
