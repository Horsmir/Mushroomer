extends Control


onready var label = $Label
var l_text = tr("Points scored: %s.\n Edible mushrooms: %s.\n Inedible mushrooms: %s.\n Number of deaths: %s.")


func _ready():
    label.text = l_text % [
        PlayerData.score, 
        PlayerData.mush_edible, 
        PlayerData.mush_inedible, 
        PlayerData.deaths,
    ]
    PlayerData.reset()
