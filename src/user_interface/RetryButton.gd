extends Button





func _on_button_up():
    PlayerData.score = PlayerData.tmp_score
    PlayerData.mush_edible = PlayerData.tmp_edible
    PlayerData.mush_inedible = PlayerData.tmp_inedible
    get_tree().paused = false
    get_tree().reload_current_scene()
