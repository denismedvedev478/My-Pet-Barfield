extends ProgressBar

func _ready():
	Player.happiness_changed.connect(change_value)
	value = 100 * Player.player_status.happiness/Player.max_value

func change_value(amount):
	value = 100 * Player.player_status.happiness/Player.max_value
