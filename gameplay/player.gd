class_name Player extends CharacterBody2D

static var current: Player:
  get:
    if not current:
      current = null
    return current
@export var speed := 4.0
var active := true

func _physics_process(delta: float) -> void:
  velocity = (Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed / delta) if active else Vector2.ZERO
  move_and_slide()

func _ready() -> void:
  if not current:
    current = self
