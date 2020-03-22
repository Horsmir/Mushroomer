extends Area2D


func take():
    $AnimatedSprite.play("open")
    set_bouns()
    yield(get_tree().create_timer(1), "timeout")
    $AnimatedSprite.animation = "empty"


func set_bouns():
    var ed_mushes = (randi() % 10) + 1
    var ined_mushes = randi() % 6
    var score_bouns = ed_mushes * 100 + ined_mushes * -100
    
    PlayerData.score += score_bouns
    PlayerData.mush_edible += ed_mushes
    PlayerData.mush_inedible += ined_mushes
