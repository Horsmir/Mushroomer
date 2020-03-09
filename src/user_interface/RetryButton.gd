extends Button





func _on_button_up():
    PlayerData.score = 0
    PlayerData.mush_edible = 0
    PlayerData.mush_inedible = 0
    get_tree().paused = false
    get_tree().reload_current_scene()
