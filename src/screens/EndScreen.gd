extends Control


onready var label = $Label


func _ready():
    label.text = label.text % [
        PlayerData.score, 
        PlayerData.mush_edible, 
        PlayerData.mush_inedible, 
        PlayerData.deaths,
    ]
