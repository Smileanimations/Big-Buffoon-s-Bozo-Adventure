### Script that connects the toolbox to functions present in the character scripts

extends Node

@onready var lvlButton = $LevelButton
@onready var dmgButton = $DamageButton
@onready var helButton = $HealingButton
@onready var Statlabel = $Label
var character

func Statsupdate():
	var txt = " "
	for stat in character.stats:
		txt += stat + " : " + str(character.stats[stat]) + "\n"
	Statlabel.text = txt
 

func startup(c):
	character = c
	name = character.name
	lvlButton.pressed.connect(character.levelUp)
	dmgButton.pressed.connect(character.applyDamage.bind(100))
	helButton.pressed.connect(character.applyHealing.bind(100))
	character.statsupdate.connect(Statsupdate)
