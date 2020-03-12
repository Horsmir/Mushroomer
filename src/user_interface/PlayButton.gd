tool
extends Button


export(String, FILE) var next_scene_path = ""


func _on_button_up():
    if get_tree().paused:
        get_tree().paused = false
        PlayerData.reset()
        PlayerData.current_level_path = next_scene_path
    get_tree().change_scene(next_scene_path)


func _get_configuration_warning():
    return "next_scene_path должен быть установлен для работы кнопки." if next_scene_path == "" else ""
