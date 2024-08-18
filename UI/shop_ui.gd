extends ItemContainerUI

@export var items: Array[ItemData]

func add_item(item: ItemData) -> Control:
  var item_ui := super(item)
  item_ui.buy.connect(_on_item_buy.bind(item))
  return item_ui

func _ready() -> void:
  super()
  for item: ItemData in items:
    add_item(item)

func _on_item_buy(item: ItemData) -> void:
  if not PlayerData.current:
    return
  if PlayerData.current.gold < item.cost:
    return
  PlayerData.current.gold -= item.cost
  PlayerData.current.items.push_back(item)
