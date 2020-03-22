extends Button



func _on_button_up():
    PlayerData.load_game()
    get_tree().change_scene(PlayerData.current_level_path)
