### Script that handles the fighting system

extends Node

@onready var charNode = $Characters
@onready var toolNode = $chartools
@onready var moveSelect = $MoveSelect
@onready var charSelect = $CharSelect

@onready var quitbutton = $Quitbutton

var toolScene = preload("res://scenes/toolbox.tscn")
var moveScene = preload("res://moves/template/MoveMenu.tscn")
var fighterScene = preload("res://characters/template/battle/BattleTemplate.tscn")

var fighters
var currMove
var currChar

var moveMenus = []
var fighterCharacters = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	fighters = getFighters()
	makeFighers()
	makeMoves()
	makeTools()


func getFighters():
	return charNode.get_children()


func makeFighers():
	for fighter in fighters:
		var f = fighterScene.instantiate()
		charSelect.add_child(f)
		f.startup(fighter, self)
		fighterCharacters[fighter.name] = f


func makeTools():
	for fighter in fighters:
		var tool = toolScene.instantiate()
		toolNode.add_child(tool)
		tool.startup(fighter, fighterCharacters[fighter.name])


func makeMoves():
	for fighter in fighters:
		var menu = moveScene.instantiate()
		moveSelect.add_child(menu)
		menu.set_name.call_deferred(fighter.name)
		moveMenus.append(fighter.name)
		for move in fighter.moveList:
			var moveChild = load(move).instantiate()
			menu.add_child(moveChild)
			moveChild.startup(fighter, self)


func moveSelected(m):
	if m == currMove:
		currMove = null
		print("Deselecting Move: %s" % m)
	else:
		currMove = m
		print("Move Selected: %s" % m)


func charSelected(c):
	if c == currChar:
		currChar = null
		moveSelect.visible = false
		print("Deselecting Character: %s" % c)
	else:
		currChar = c
		moveSelect.visible = true
		moveSelect.current_tab = moveMenus.find(c.name)
		print("Character Selected: %s" % c)


func _on_quitbutton_pressed():
	get_tree().quit()
