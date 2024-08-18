@tool
extends PanelContainer

@export var item: ItemData:
  set(value):
    item = value
    _update_ui()

func _update_ui() -> void:
  if not item or not is_inside_tree():
    return
  var cost_label: Label = get_node_or_null(^"VBoxContainer/Cost")
  if is_instance_valid(cost_label):
    cost_label.text = "$" + str(item.cost)
  $VBoxContainer/Name.text = item.resource_path.get_file().get_basename().capitalize()

func _ready() -> void:
  _update_ui()

func _on_buy_pressed() -> void:
  buy.emit()

signal buy
