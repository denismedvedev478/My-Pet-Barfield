extends ProgressBar

func _ready():
	Player.hygiene_changed.connect(change_value)
	value = 100 * Player.player_status.hygiene/Player.max_value

func change_value(amount):
	value = 100 * Player.player_status.hygiene/Player.max_value
