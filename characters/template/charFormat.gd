### Script that handles character information

extends Node

# Emitted when the character's stats change
signal statsChanged
# Emitted when the character's health changees
signal healthChanged
# Emitted when the character's level changes
signal levelChanged
# Emitted when the character's stamina changes
signal staminaChanged

# Base stats for character
@export var statsBase = {
	"HealthMax" : 100,
	"StaminaMax" : 100,
	"Speed" : 5,
	"Defense" : 10,
}

# Stats gained on level up
@export var statsPerLevel = {
	"HealthMax" : 5,
	"StaminaMax" : 5,
	"Speed" : 1,
	"Defense" : 2,
}

# Current stats for character
@export var stats = {
	"XP" : 0,
}

# The faction that the character belongs to
@export_enum ("Player", "Enemy") var charFaction: String = "Player"

# The moves that the character has
@export var moveList : PackedStringArray


# Called when the node enters the scene tree for the first time.
func _ready():
# Generates the characters stats
	calcStats()
# Heals the character, this will be used to set the character's health to its saved value when saving is added
	setHealth(INF)
# Refills the character's stamina
	setStamina(INF)


# Function to set the health of a character to `val`
# `val` is clamped to remain between 0 and the character's max health
func setHealth(val):
	stats["Health"] = clamp(val, 0, stats["HealthMax"])
	statsChanged.emit()


# Function to set the stamina of a character to `val`
# `val` is clamped to remain between 0 and the character's max stamina
func setStamina(val):
	stats["Stamina"] = clamp(val, 0, stats["StaminaMax"])
	statsChanged.emit()


# Fuction to calculate the current stats of the character
func calcStats():
# Starts by calculating the character's current level
	calcLevel()

# Iterates through the list of base stats
	for stat in statsBase:
# For every stat, calculates it's current value based on the character's level and the stats gained per level
		stats[stat] = statsBase[stat] + (statsPerLevel[stat] * stats["Level"])

# Prints the character's current stats
	print(stats)
	statsChanged.emit()


# var that shows how much xp is required to reach the next level
var xpToNext = 0
# Function to calculate the character's level based on how much XP they have
func calcLevel():
# How much XP the character has
	var xp = stats["XP"]
# The character's calculated level
	var Lvl = 0
# How much XP the next level requires
	var nxtLvl = 100
# The scaling factor for each level
	var lvlScale = 1.3

# Runs the character has more XP than is required for the next level
	while xp >= nxtLvl:
# Subtract the XP required to level
		xp -=nxtLvl
# Calculate how much XP would be required to level up again
		nxtLvl = int(nxtLvl * lvlScale)
# Increment the level counter by 1
		Lvl += 1
# Set `xpToNext` so that we know how much XP the character needs to level again
	xpToNext = nxtLvl - xp
# Set the character's level to the value we calulated
	stats["Level"] = Lvl


# Helper function that adds enough XP to the character to level up
func levelUp():
# Print the XP required to level
	print("Adding %s XP to level up." % xpToNext)
# Add the required XP to the character's XP
	stats["XP"] += xpToNext
# Re-calculate the character's current stats with the new level
	calcStats()
	#Just like the one up here ^ its sends a signal when the level up button is pressed
	levelChanged.emit()


# Function that calculates how much damage the character should take when hit
func applyDamage(damage):
# Print how much damage is being dealt
	print("Applying %s damage to %s" % [damage, name])
# Reduce the damage based on the character's defense stat
	damage = max(damage - stats["Defense"], 0)
# Print the reduced damage and the amount it was reduced by
	print("Damage reduced to %s by %s defense" % [damage, stats["Defense"]])
# Update the character's health with the damage applied, value is locked above 0
	stats["Health"] = max(stats["Health"] - damage, 0)
# Print the character's stats
	print(stats)
	statsChanged.emit()
	#Just like the one up here ^ its sends a signal when the damage button is pressed
	healthChanged.emit(-damage)

# Function that calculates how much healing the character should receive
func applyHealing(healing):
# Print how much healing is being received
	print("Applying %s healing to %s" % [healing, name])
# Update the character's health with the healing received, value is capped at the player's max HP
	stats["Health"] = min(stats["Health"] + healing, stats["HealthMax"])
# Print the character's stats
	print(stats)
	statsChanged.emit()
	#Just like the one up here ^ its sends a signal when the healing button is pressed
	healthChanged.emit(healing)

#its the one ^ up there but instead of health its stamina!
func applyStamina(stamina):
	# Prints the amount of stamina recovered
	print("Recovering %s stamina to %s" % [stamina,name])
	# Calculates the amount of stamina to recover
	stats["Stamina"] = min(stats["Stamina"] + stamina, stats["StaminaMax"])
	# Prints all the character's stats
	print(stats)
	statsChanged.emit()
	staminaChanged.emit(stamina)
	

func calcEffect(move):
	for effect in move.moveEffects:
		var val = move.moveEffects[effect]
		match effect:
			"Damage":
				applyDamage(val)
			"Healing":
				applyHealing(val)


func moveSelected(_what):
	pass
