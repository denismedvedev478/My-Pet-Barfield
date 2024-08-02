extends Control

@onready var button = $VBoxContainer/HBoxContainer/VBoxContainer/TabContainer/TabBar/VBoxContainer/ProceedButton

signal proceed_button_pressed_loader_signal

func _ready():
	button.modulate.v += 0.1
	
var t = 0
func _process(delta):
	button.modulate.v += 0.01*cos(6*t)
	t += delta;


func _on_proceed_button_pressed():
	proceed_button_pressed_loader_signal.emit()
	$AnimationPlayer.play("close tutorial menu")
	await $AnimationPlayer.animation_finished
	queue_free()
