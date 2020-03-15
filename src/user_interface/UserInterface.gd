extends Control


onready var scene_tree = get_tree()
onready var pause_overlay = $PauseOverlay
onready var score = $InfoGame/Label
onready var pause_title = $PauseOverlay/Title
onready var mush_edible = $InfoGame/HBoxContainer/Label
onready var mush_inedible = $InfoGame/HBoxContainer2/Label

var DIED_MESSAGE = tr("You are dead!")
var SCORE_STRING = tr("Score: %s")

var paused = false setget set_paused


func _ready():
    PlayerData.connect("score_updated", self, "update_interface")
    PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
    update_interface()
    
    PlayerData.tmp_score = PlayerData.score
    PlayerData.tmp_edible = PlayerData.mush_edible
    PlayerData.tmp_inedible = PlayerData.mush_inedible


func _on_PlayerData_player_died():
    self.paused = true
    pause_title.text = DIED_MESSAGE


func _unhandled_input(event):
    if event.is_action_pressed("pause") and pause_title.text != DIED_MESSAGE:
        self.paused = not paused
        scene_tree.set_input_as_handled()


func update_interface():    
    score.text = SCORE_STRING % [PlayerData.score]
    mush_edible.text = str(PlayerData.mush_edible)
    mush_inedible.text = str(PlayerData.mush_inedible)


func set_paused(value):
    paused = value
    scene_tree.paused = value
    pause_overlay.visible = value
