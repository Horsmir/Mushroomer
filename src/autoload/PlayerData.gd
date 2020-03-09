extends Node


signal score_updated
signal player_died


enum MushType {EDIBLE, INEDIBLE}


var score = 0 setget set_score
var deaths = 0 setget set_deaths
var mush_edible = 0 setget set_mush_edible
var mush_inedible = 0 setget set_mush_inedible


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
