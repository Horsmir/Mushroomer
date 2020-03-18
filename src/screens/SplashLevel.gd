extends Control


export var level_num = 0
export var level_name = ""

onready var num_level_label = $VBoxContainer/NumLevel
onready var level_name_level = $VBoxContainer/LevelName


func _ready():
    num_level_label.text = tr("Level %s" % level_num)
    level_name_level.text = '"%s"' % level_name


func _on_Timer_timeout():
    queue_free()
