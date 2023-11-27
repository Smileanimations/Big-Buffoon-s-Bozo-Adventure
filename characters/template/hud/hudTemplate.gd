extends Node

@onready var healthBar = $HealthBar
@onready var stamBar = $StamBar
@onready var parryBar = $ParryBar
@onready var parryTimer = $ParryTimer
var character
var stats
<<<<<<< Updated upstream
signal parryChanged

=======
<<<<<<< HEAD
signal parrychanged
=======
signal parryChanged

>>>>>>> e1b127cdf2903b67936e14e657f01f5404edf046
>>>>>>> Stashed changes

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


#adds a point every second!
func _on_parry_timer_timeout():
	parryBar.value += 5
	if parryBar.value == parryBar.max_value:
		parryBar.max_value *= 2
		parryBar.value = 0
<<<<<<< Updated upstream
		parryChanged.emit(parryBar.value, parryBar.max_value)

=======
<<<<<<< HEAD
		parrychanged.emit(parryBar.value, parryBar.max_value)
=======
		parryChanged.emit(parryBar.value, parryBar.max_value)

>>>>>>> e1b127cdf2903b67936e14e657f01f5404edf046
>>>>>>> Stashed changes

