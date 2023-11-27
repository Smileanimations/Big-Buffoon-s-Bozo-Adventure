### Script that connects the toolbox to functions present in the character scripts

extends Node

@onready var lvlButton = $ToolButtons/LevelButton
@onready var dmgButton = $ToolButtons/DamageButton
@onready var helButton = $ToolButtons/HealingButton
@onready var statLabel = $StatLabel
##This is the label showing all the results after pressing one of buttons thus the name "Results"
@onready var resultLabel = $ResultLabel
@onready var timer = $ResultTimer

@onready var healthBar = $HealthBar


var character


func updateStats():
	var txt = ""
	for stat in character.stats:
		txt += "%s : %s\n" % [stat, character.stats[stat]]
	statLabel.text = txt

	healthBar.max_value = character.stats["HealthMax"]
	healthBar.value = character.stats["Health"]

 
# All these functions basically do the same thing: When the Level up, Damage or Heal button is pressed 
# it will Display text underneath all the stats displaying how much damage has been taken or health has been
# regenerated. Or simply "Level Up!"
func updateHealth(val):
# If the value is positive the character gained health, if it's negative they lost health
	if val < 0:
		resultLabel.text = "Player received %s Damage" % abs(val)
	elif val > 0:
		resultLabel.text = "Player received %s Healing" % val

# Starts a timer, after which the text is removed
	timer.start()


func updateLevel():
	resultLabel.text = "Level Up!"
	timer.start()


func startup(c, f):
	character = c
	name = character.name
# Connects the toolbox buttons to the character
	lvlButton.pressed.connect(character.levelUp)
	dmgButton.pressed.connect(character.applyDamage.bind(100))
	helButton.pressed.connect(character.applyHealing.bind(100))
# Connects the character's signals to the toolbox
	character.statsChanged.connect(updateStats)
	character.healthChanged.connect(updateHealth)
	character.levelChanged.connect(updateLevel)
	hubTemplate.parrychanged.connect(updateStats)
# Updates the stat display so it's not blank on startup
	f.hud.parryChanged.connect(parryChanged)
	updateStats()


# Removes the text after the 2 second timer runs out
func _on_timer_timeout():
	resultLabel.text = ""


func parryChanged(val, valMax):
	print(val)
	print(valMax)
