extends Label

var gold: int

func _process(delta: float) -> void:
  if is_instance_valid(PlayerData.current):
    gold = move_toward(gold, PlayerData.current.gold, 100 * delta)
  text = "$" + str(gold)

func _ready() -> void:
  gold = 0 if not PlayerData.current else PlayerData.current.gold
