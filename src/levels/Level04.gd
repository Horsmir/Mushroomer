extends Node2D


onready var bridge = $ObjectsBehind/BridgeOne


func _on_ButtonStoneGr_button_activated():
    bridge.down()
