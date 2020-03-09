tool
extends Area2D


onready var anim_player = $AnimationPlayer

export (PackedScene) var next_scene = null


func _on_Portal_body_entered(body):
    teleport()


func _get_configuration_warning():
    return "Свойство next_scene не может быть пустым" if not next_scene else "" 


func teleport():
    anim_player.play("fade_in")
    yield(anim_player, "animation_finished")
    get_tree().change_scene_to(next_scene)
