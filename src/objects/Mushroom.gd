extends Area2D


export (PlayerData.MushType) var mushroom_type = PlayerData.MushType.EDIBLE

export var score = 100

func take():
    $AnimationPlayer.play("take")
    PlayerData.score += score
    if mushroom_type == PlayerData.MushType.EDIBLE:
        PlayerData.mush_edible += 1
    else:
        PlayerData.mush_inedible += 1
        PlayerData.mush_edible -= 1
    yield($AnimationPlayer, "animation_finished")
    queue_free()
