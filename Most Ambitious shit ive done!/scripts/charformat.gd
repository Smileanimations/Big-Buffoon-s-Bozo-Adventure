extends Node

@export var statsBase = {
	"HealthMax" : 100,
	"Speed" : 5,
	"Defense" : 20,
}

@export var statsPerLevel = {
	"HealthMax" : 5,
	"Speed" : 1,
	"Defense" : 2,
}

@export var stats = {
	"XP" : 0,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	calcStats()
	setHealth(INF)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func setHealth(val):
	stats["Health"] = clamp(val, 0, stats["HealthMax"])


func calcStats():
	calcLevel()
	for stat in statsBase:
		stats[stat] = statsBase[stat] + (statsPerLevel[stat] * stats["Level"])
	print(stats)

var xpToNext = 0
func calcLevel():
	var xp = stats["XP"]
	var Lvl = 0
	var nxtLvl = 100
	var lvlScale = 1.3
	while xp >= nxtLvl:
		xp -=nxtLvl
		nxtLvl = int(nxtLvl * lvlScale)
		Lvl += 1
	xpToNext = nxtLvl - xp
	stats["Level"] = Lvl


func levelUp():
	calcLevel()
	print("Adding %s XP to level up." % xpToNext)
	stats["XP"] += xpToNext
	calcStats()


func applyDamage(damage):
	print("Applying %s damage to %s" % [damage, name])
	damage = max(damage - stats["Defense"], 0)
	print("Damage reduced to %s by %s defense" % [damage, stats["Defense"]])
	stats["Health"] = max(stats["Health"] - damage, 0)
	print(stats)


func applyHealing(healing):
	print("Applying %s healing to %s" % [healing, name])
	stats["Health"] = min(stats["Health"] + healing, stats["HealthMax"])
	print(stats)

