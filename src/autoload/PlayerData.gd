extends Node


signal score_updated
signal player_died


enum MushType {EDIBLE, INEDIBLE}


var score = 0 setget set_score
var deaths = 0 setget set_deaths
var mush_edible = 0 setget set_mush_edible
var mush_inedible = 0 setget set_mush_inedible

var tmp_score = 0
var tmp_edible = 0
var tmp_inedible = 0

var current_level_path = null
var save_file_name = "user://mushroomer.save"


func _ready():
    randomize()


func reset():
    score = 0
    deaths = 0
    mush_edible = 0
    mush_inedible = 0


func set_score(value):
    score = value
    emit_signal("score_updated")


func set_deaths(value):
    deaths = value
    emit_signal("player_died")


func set_mush_edible(value):
    mush_edible = value
    emit_signal("score_updated")


func set_mush_inedible(value):
    mush_inedible = value
    emit_signal("score_updated")


func save():
    var save_dict = {
        "filename": get_filename(),
        "parent": get_parent().get_path(),
        "score": score,
        "deaths": deaths,
        "mush_edible": mush_edible,
        "mush_inedible": mush_inedible,
        "current_level": current_level_path,        
       }
    return save_dict


func load_param(save_dict):
    score = save_dict["score"]
    deaths = save_dict["deaths"]
    mush_edible = save_dict["mush_edible"]
    mush_inedible = save_dict["mush_inedible"]
    current_level_path = save_dict["current_level"]
    

func save_game():
    var save_game_file = File.new()
    save_game_file.open(save_file_name, File.WRITE)
    var node_data = save()
    save_game_file.store_line(to_json(node_data))
    save_game_file.close()


func load_game():
    var save_game_file = File.new()
    if not save_game_file.file_exists(save_file_name):
        return
        
    save_game_file.open(save_file_name, File.READ)
    while save_game_file.get_position() < save_game_file.get_len():
        var node_data = parse_json(save_game_file.get_line())
        load_param(node_data)
    save_game_file.close()
