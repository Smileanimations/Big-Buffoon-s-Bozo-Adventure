### Script that handles the fighting system

extends Node

@onready var charNode = $Characters
@onready var toolNode = $chartools
@onready var quitbutton = $Quitbutton

var toolScene = "res://scenes/toolbox.tscn"

var fighters

# Called when the node enters the scene tree for the first time.
func _ready():
	fighters = getFighters()
	makeTools()



func getFighters():
	return charNode.get_children()


func makeTools():
	for fighter in fighters:
		var tool = load(toolScene).instantiate()
		toolNode.add_child(tool)
		tool.startup(fighter)


func _on_quitbutton_pressed():
	get_tree().quit()
