extends Area2D

@export_range(0.0, 1.0, 0.01, "or_greater") var notifier_tween_time := 0.1
@onready var notifier: CanvasItem = $Signifier
var player_inside := false

func _process(_delta: float) -> void:
  if not Player.current:
    return
  if not Player.current.active:
    return
  if not player_inside:
    return
  if Input.is_action_just_pressed(&"ui_accept"):
    interact.emit()

var notifier_tween: Tween
func _create_notifier_tween() -> Tween:
  if is_instance_valid(notifier_tween) and notifier_tween.is_running():
    notifier_tween.kill()
  notifier_tween = create_tween()
  notifier_tween.set_trans(Tween.TRANS_CUBIC)
  notifier_tween.set_ease(Tween.EASE_OUT)
  return notifier_tween

func _on_body_entered(body: Node2D) -> void:
  if player_inside:
    return
  if body is Player:
    player_inside = true
  var tween := _create_notifier_tween()
  tween.tween_property(notifier, ^"modulate:a", 1.0, notifier_tween_time)
  tween.parallel().tween_property(notifier, ^"position:y", -32.0, notifier_tween_time)
  for i: int in range(1, 4):
    tween.tween_property(notifier, ^"rotation_degrees", 15.0 / float(i), 0.05)
    tween.tween_property(notifier, ^"rotation_degrees", -15.0 / float(i), 0.05)
  tween.tween_property(notifier, ^"rotation_degrees", 0.0, 0.025)

func _on_body_exited(body: Node2D) -> void:
  if not player_inside:
    return
  if body is Player:
    player_inside = false
  var tween := _create_notifier_tween()
  tween.tween_property(notifier, ^"modulate:a", 0.0, notifier_tween_time)
  tween.parallel().tween_property(notifier, ^"position:y", 0, notifier_tween_time)

signal interact
