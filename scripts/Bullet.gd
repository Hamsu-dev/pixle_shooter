extends CharacterBody2D

const speed = 600
@onready var smokeScene = preload("res://scenes/BulletSmoke.tscn")
@onready var bulletImpact = preload("res://scenes/BulletImpact.tscn")


var direction = Vector2.ZERO
const BULLET_COLLISION_LAYER = 1
const BULLET_COLLISION_MASK = 1

func _ready():
	set_collision_layer(BULLET_COLLISION_LAYER)
	set_collision_mask(BULLET_COLLISION_MASK)
	
func _process(delta):
	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult != null:
		var smoke = smokeScene.instantiate() as GPUParticles2D
		get_parent().add_child(smoke)
		smoke.global_position = collisionResult.get_position()
		smoke.rotation = collisionResult.get_normal().angle()
		
		var impact = bulletImpact.instantiate() as Node2D
		get_parent().add_child(impact)
		impact.global_position = collisionResult.get_position()
		impact.rotation = collisionResult.get_normal().angle()
		queue_free()
