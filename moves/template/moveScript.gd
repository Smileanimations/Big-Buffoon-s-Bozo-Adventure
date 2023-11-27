extends Node

# Signal is emitted when the move is selected
signal wasSelected

# What character the move belongs to
var character

# The fight scene node
var fight

@onready var selectButton = $MoveSelect
@onready var nameLabel = $MoveLabels/MoveName
@onready var descLabel = $MoveLabels/MoveDesc

# The name and description of the move
@export var moveName : String
@export var moveDesc : String

# A dictionary to add move properties, such as damage, healing, bleed or poison effects
@export var moveEffects : Dictionary

# Who the move can target
@export_enum("Self", "Allies", "Enemies", "All") var moveTargets : String = "All"


# Connects the move to the character that owns it
func startup(c, f):
	character = c
	fight = f
	selectButton.pressed.connect(moveSelected)
	wasSelected.connect(character.moveSelected)
	wasSelected.connect(fight.moveSelected)


# Set up labels and node name
func _ready():
	set_name.call_deferred(moveName)
	nameLabel.text = moveName
	descLabel.text = moveDesc


# Runs when the move is selected
func moveSelected():
	wasSelected.emit(self)
