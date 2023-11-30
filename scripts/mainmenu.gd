extends Node

@onready var music = $Audio

func _ready():
	music.play()
	
func _process(delta):
	pass
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/FightTest.tscn")
	music.stream_paused = true
	
func _on_quit_pressed():
	get_tree().quit()
	
func _on_option_pressed():
	get_tree().change_scene_to_file("res://scenes/Options.tscn")




#Options
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
	

