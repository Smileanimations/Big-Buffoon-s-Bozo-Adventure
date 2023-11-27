extends Node


@onready var hud = $HUD
@onready var sprite = $Sprite2D
@onready var nameplate = $Label
@onready var selectButton = $Button

var character
var fight

func startup(c, f):
	character = c
	fight = f
	hud.startup(c)
	nameplate.text = c.name

func _ready():
	selectButton.pressed.connect(charSelected)


func charSelected():
	if fight.currMove:
		character.calcEffect(fight.currMove)
		fight.currMove = null
	else:
		fight.charSelected(character)
