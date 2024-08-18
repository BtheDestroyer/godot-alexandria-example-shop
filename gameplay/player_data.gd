class_name PlayerData extends Resource

static var current: PlayerData:
  get:
    if not current:
      current = null
    return current

@export var gold := 0
@export var items: Array[ItemData]

static func _static_init() -> void:
  current = load("./player_data.res") as PlayerData
