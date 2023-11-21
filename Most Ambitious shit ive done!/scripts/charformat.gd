extends Node

@export var statsbase = {
	"Health" : 100,
	"Speed" : 5,
	"Defense" : 20,
}

@export var statsPerLevel = {
	"Health" : 5,
	"Speed" : 1,
	"Defense" : 2,
}

@export var stats = {
	"XP" : 0,
	"Level" : 0,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	calcStats()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func calcStats():
	for stat in statsbase:
		stats[stat] = statsbase[stat] + (statsPerLevel[stat] * stats["Level"])
		print(stats)

func levelUp():
	stats["Level"] += 1
	calcStats()

func applyDamage(damage):
	stats["Health"] -= max(damage - stats["Defense"], 0)
	print(stats)


func _on_pressed():
	pass # Replace with function body.


func _on_button_2_pressed():
	pass # Replace with function body.
