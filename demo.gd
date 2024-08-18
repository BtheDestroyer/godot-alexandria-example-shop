extends Control

@export var shop_ui_prefab: PackedScene
@export var inventory_prefab: PackedScene

var current_ui: Control

func _on_store_interact() -> void:
  if not current_ui:
    current_ui = shop_ui_prefab.instantiate()
    add_child(current_ui)

func _process(_delta: float) -> void:
  if not current_ui:
    if Input.is_action_just_pressed("ui_cancel"):
      current_ui = inventory_prefab.instantiate()
      add_child(current_ui)
