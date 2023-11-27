extends Node

@onready var healthBar = $HealthBar
@onready var stamBar = $StamBar
@onready var parryBar = $ParryBar
@onready var parryTimer = $ParryTimer
var character
var stats

func startup(c):
	character = c
	stats = c.stats
	c.statsChanged.connect(update)
	update()
	parryTimer.start()


func _ready():
	pass


func update():
# Update health bar
	healthBar.max_value = stats["HealthMax"]
	healthBar.value = stats["Health"]
# Update stamina bar
	stamBar.max_value  = stats["StaminaMax"]
	stamBar.value = stats["Stamina"]
# Update Parry bar
	parryBar.max_value  = 100
	
#adds a point every second!
func _on_parry_timer_timeout():
	parryBar.value += 1
