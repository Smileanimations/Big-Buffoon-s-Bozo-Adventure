### Script that handles the fighting system

extends Node

@onready var charNode = $Characters
@onready var toolNode = $chartools
@onready var moveNode = $MoveMenu

@onready var quitbutton = $Quitbutton

var toolScene = preload("res://scenes/toolbox.tscn")
var moveScene = preload("res://moves/template/MoveMenu.tscn")

var fighters

# Called when the node enters the scene tree for the first time.
func _ready():
	fighters = getFighters()
	makeTools()
	makeMoves()


func getFighters():
	return charNode.get_children()


func makeTools():
	for fighter in fighters:
		var tool = toolScene.instantiate()
		toolNode.add_child(tool)
		tool.startup(fighter)


func makeMoves():
	for fighter in fighters:
		var menu = moveScene.instantiate()
		moveNode.add_child(menu)
		menu.set_name.call_deferred(fighter.name)
		for move in fighter.moveList:
			var moveChild = load(move).instantiate()
			menu.add_child(moveChild)
			moveChild.startup(fighter)


func _on_quitbutton_pressed():
	get_tree().quit()
