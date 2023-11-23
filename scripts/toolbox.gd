### Script that connects the toolbox to functions present in the character scripts

extends Node

@onready var lvlButton = $LevelButton
@onready var dmgButton = $DamageButton
@onready var helButton = $HealingButton
@onready var statLabel = $Label
@onready var damageLabel = $CagedAnimal
@onready var timer = $Timer
var tijd = 1
var character

func updateStats():
	var txt = " "
	for stat in character.stats:
		txt += stat + " : " + str(character.stats[stat]) + "\n"
	statLabel.text = txt
 
func updateDamage(damage):
	timer.start()
	damageLabel.text = "Player took " + str(damage) + " Damage"


func updateHealth(healing):
	timer.start()
	damageLabel.text = "Player Healed " + str(healing) + " HP"

func updateLevel():
	timer.start()
	damageLabel.text = "Level Up!"

	
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


func _on_timer_timeout():
	damageLabel.text = " "
	
