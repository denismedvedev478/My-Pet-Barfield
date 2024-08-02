extends VBoxContainer

var FeedButtonLasagna;
var FeedButton2;
var FeedButton3;
var FeedButtonSpaghetti; 

# Called when the node enters the scene tree for the first time.
func _ready():
	# pick random buttons
	FeedButtonLasagna = $FeedButtonLasagna;
	FeedButton2 = $FeedButton2;
	FeedButton3 = $FeedButton3;
	FeedButtonSpaghetti = $FeedButtonSpaghetti;
	
	if (randi_range(1, 2) == 1):	FeedButtonLasagna.queue_free();
	else:	FeedButton2.queue_free();

	if (randi_range(3, 4) == 3):	FeedButton3.queue_free();
	else:	FeedButtonSpaghetti.queue_free();

