### Script that connects the toolbox to functions present in the character scripts

extends Node

@onready var lvlButton = $LevelButton
@onready var dmgButton = $DamageButton
@onready var helButton = $HealingButton

var character

func startup(c):
	character = c
	name = character.name
	lvlButton.pressed.connect(character.levelUp)
	dmgButton.pressed.connect(character.applyDamage.bind(100))
	helButton.pressed.connect(character.applyHealing.bind(100))
