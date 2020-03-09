extends KinematicBody2D
class_name Actor


const FLOOR_NORMAL = Vector2.UP

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var _velocity = Vector2.ZERO
