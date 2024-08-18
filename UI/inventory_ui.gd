extends ItemContainerUI

func _ready() -> void:
  super()
  if PlayerData.current:
    for item: ItemData in PlayerData.current.items:
      add_item(item)
