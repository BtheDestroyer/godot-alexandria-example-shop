class_name ItemContainerUI extends AspectRatioContainer

@export var item_ui_prefab: PackedScene
@onready var item_container := $PanelContainer/MarginContainer/VBoxContainer/GridContainer

func add_item(item: ItemData) -> Control:
  var item_ui: Control = item_ui_prefab.instantiate()
  item_ui.item = item
  item_container.add_child(item_ui)
  return item_ui

func clear_items() -> void:
  for child: Node in item_container.get_children():
    child.queue_free()

var movement_tween: Tween
func _ready() -> void:
  if Player.current:
    Player.current.active = false
  mouse_filter = MOUSE_FILTER_STOP
  movement_tween = create_tween()
  movement_tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
  anchor_top = 1.0
  anchor_bottom = 2.0
  movement_tween.tween_property(self, ^"anchor_top", 0.0, 0.25)
  movement_tween.parallel().tween_property(self, ^"anchor_bottom", 1.0, 0.25)
  await movement_tween.finished
  mouse_filter = MOUSE_FILTER_PASS

func _on_exit_pressed() -> void:
  if is_instance_valid(movement_tween) and movement_tween.is_running():
    movement_tween.kill()
  mouse_filter = MOUSE_FILTER_STOP
  movement_tween = create_tween()
  movement_tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
  movement_tween.tween_property(self, ^"anchor_top", 1.0, 0.25)
  movement_tween.parallel().tween_property(self, ^"anchor_bottom", 2.0, 0.25)
  await movement_tween.finished
  if Player.current:
    Player.current.active = true
  queue_free()

func _on_item_buy(item: ItemData) -> void:
  if not PlayerData.current:
    return
  if PlayerData.current.gold < item.cost:
    return
  PlayerData.current.gold -= item.cost
  PlayerData.current.items.push_back(item)
