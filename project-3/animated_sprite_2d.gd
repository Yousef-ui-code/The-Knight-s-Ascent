extends AnimatedSprite2D

# Fixed the spelling to 'manager'
@onready var game_manager: Node = $"../../../game maneger"

func _on_coin_body_entered(body: Node2D) -> void:
	# Now this matches the variable name above
	game_manager.add_point()
	queue_free()
	
	
