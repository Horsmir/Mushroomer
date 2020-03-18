extends Actor


onready var gun_ray = $GunRay
onready var anim = $AnimatedSprite

export var camera_limit_right = 20000

var is_shooting = false
var is_stated = true
var is_attaking = false
var is_jumping = false
var is_dead = false


func _ready():
    $Camera2D.limit_right = camera_limit_right


func get_input():
    if is_attaking or is_shooting or is_dead:
        return
    
    var dir = 0
    
    if Input.is_action_just_pressed("shoot"):
        if PlayerData.mush_inedible > 0 and is_stated:
            is_shooting = true
            anim.play("shoot")
            $AudioGun.play()
        return
    
    if Input.is_action_just_pressed("attack1"):
        if is_on_floor() and is_stated and not is_jumping:
            is_attaking = true
            attack1()
            return
    
    if Input.is_action_pressed("move_right"):
        dir += 1
        anim.flip_h = false
        gun_ray.scale.x = 1
    if Input.is_action_pressed("move_left"):
        dir -= 1
        anim.flip_h = true
        gun_ray.scale.x = -1
    if dir != 0:
        _velocity.x = lerp(_velocity.x, dir * speed, acceleration)
        if is_on_floor() and not is_jumping:
            is_stated = false
            anim.play("run")
    else:
        _velocity.x = lerp(_velocity.x, 0, friction)
        if is_on_floor() and not is_jumping:
            anim.play("idle")
            is_stated = true
    if sign(dir) != sign($HitBox.position.x) and dir != 0:
        $HitBox.position.x *= -1
        

func _physics_process(delta):
    get_input()
    _velocity.y += gravity * delta
    _velocity = move_and_slide(_velocity, FLOOR_NORMAL)
    if Input.is_action_just_pressed("jump"):
        if is_on_floor() and not is_attaking:
            is_jumping = true
            anim.play("jump")
            _velocity.y = jump_speed


func die():
    is_dead = true
    anim.play("dead")


func attack1():
    is_attaking = true
    anim.play("melee")
    $AudioAttack.play()
    yield(get_tree().create_timer(0.2), "timeout")
    $HitBox/CollisionShape2D.set_deferred("disabled", false)
    


func shoot():
    PlayerData.mush_inedible -= 1
    if gun_ray.is_colliding():
        var enem = gun_ray.get_collider()
        if enem.has_method("sleeping"):
            enem.sleeping()


func _on_HitBox_area_entered(area):
    if area.is_in_group("hurtbox"):
        area.take()

func end_die():
    PlayerData.deaths += 1
    set_physics_process(false)


func _on_VisibilityNotifier2D_screen_exited():
    die()


func _on_AnimatedSprite_animation_finished():
    if anim.animation == "melee":
        $HitBox/CollisionShape2D.set_deferred("disabled", true)
        $AudioAttack.stop()
        is_attaking = false
    if anim.animation == "shoot":
        $AudioGun.stop()
        shoot()
        is_shooting = false
    if anim.animation == "jump":
        is_jumping = false
    if anim.animation == "dead":
        end_die()
