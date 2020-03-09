extends Control


onready var scene_tree = get_tree()
onready var pause_overlay = $PauseOverlay
onready var score = $Label
onready var pause_title = $PauseOverlay/Title

const DIED_MESSAGE = "Вы погибли!"
const SCORE_STRING = "Очки: %s\nСъедобные: %s\nНесъедобные: %s"

var paused = false setget set_paused


func _ready():
    PlayerData.connect("score_updated", self, "update_interface")
    PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
    update_interface()


func _on_PlayerData_player_died():
    self.paused = true
    pause_title.text = DIED_MESSAGE


func _unhandled_input(event):
    if event.is_action_pressed("pause") and pause_title.text != DIED_MESSAGE:
        self.paused = not paused
        scene_tree.set_input_as_handled()


func update_interface():    
    score.text = SCORE_STRING % [
        PlayerData.score, 
        PlayerData.mush_edible, 
        PlayerData.mush_inedible,
        ]


func set_paused(value):
    paused = value
    scene_tree.paused = value
    pause_overlay.visible = value
