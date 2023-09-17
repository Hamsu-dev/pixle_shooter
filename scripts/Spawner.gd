extends Node2D

@onready var bulletScene = preload("res://scenes/Bullet.tscn")
var mouse_pressed = false

func _ready():
	pass

func _unhandled_input(_event):
	if Input.is_action_pressed('fire'):
		mouse_pressed = true
		
	if Input.is_action_just_released('fire') and mouse_pressed:
		var bullet = bulletScene.instantiate() as Node2D
		get_parent().add_child(bullet)
		bullet.global_position = self.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		bullet.rotation = bullet.direction.angle()
		mouse_pressed = false
