### Script that connects the toolbox to functions present in the character scripts

extends Node

@onready var lvlButton = $LevelButton
@onready var dmgButton = $DamageButton
@onready var helButton = $HealingButton
@onready var statLabel = $Label
##This is the label showing all the results after pressing one of buttons thus the name "Results"
@onready var resultLabel = $Results
@onready var timer = $Timer
var tijd = 1
var character

func updateStats():
	var txt = " "
	for stat in character.stats:
		txt += stat + " : " + str(character.stats[stat]) + "\n"
	statLabel.text = txt
 
## All these functions basically do the same thing: When the Level up, Damage or Heal button is pressed 
## it will Display text underneath all the stats displaying how much damage has been taken or health has been
## regenerated. Or simply "Level Up!"

func updateDamage(damage):
	# Added a timer for 3 seconds, function for when it ends is \/ down there \/
	timer.start()
	resultLabel.text = "Player took " + str(damage) + " Damage"


func updateHealth(healing):
	timer.start()
	resultLabel.text = "Player Healed " + str(healing) + " HP"

func updateLevel():
	timer.start()
	resultLabel.text = "Level Up!"

	
func startup(c):
	character = c
	name = character.name
	lvlButton.pressed.connect(character.levelUp)
	dmgButton.pressed.connect(character.applyDamage.bind(100))
	helButton.pressed.connect(character.applyHealing.bind(100))
	character.statsChanged.connect(updateStats)
	character.damageChanged.connect(updateDamage)
	character.healthChanged.connect(updateHealth)
	character.levelChanged.connect(updateLevel)
	updateStats()

#Removes the text after the 3 second timer runs out (basically a simple space but it looks cool in practice)
func _on_timer_timeout():
	resultLabel.text = " "
	
