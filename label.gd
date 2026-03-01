extends Label

func _process(delta: float) -> void:
	# Получаем ссылку на узел игрока
	var player = $"../../Player/Player"
	
	# Проверяем, что игрок существует (чтобы игра не вылетала после его смерти)
	if player:
		text = "HP: " + str(player.health)

var health: int = 100 # Убедитесь, что эта строка есть!

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
