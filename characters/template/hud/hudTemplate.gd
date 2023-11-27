extends Node

@onready var healthBar = $HealthBar
@onready var stamBar = $StamBar
@onready var parryBar = $ParryBar

var character
var stats


func startup(c):
	character = c
	stats = c.stats
	c.statsChanged.connect(update)
	update()


func _ready():
	pass


func update():
# Update health bar
	healthBar.max_value = stats["HealthMax"]
	healthBar.value = stats["Health"]
# Update stamina bar
	stamBar.max_value  = stats["StaminaMax"]
	stamBar.value = stats["Stamina"]
