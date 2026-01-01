extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("Die")
	Engine.time_scale = 0.5
	
	# 1. Fixed the spelling of "Collision"
	# 2. Used get_node_or_null so the game doesn't crash if it's missing
	var collision_node = body.get_node_or_null("CollisionShape2D")
	
	if collision_node:
		collision_node.queue_free()
	
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.2
	get_tree().reload_current_scene()
