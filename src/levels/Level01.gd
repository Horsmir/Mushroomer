extends Node2D


func _ready():
    PlayerData.current_level_path = filename
    PlayerData.save_game()

