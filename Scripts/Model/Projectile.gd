extends GameElement
class_name Projectile 

@export var damage : int
@export var velocity : int 

@onready var projectileAnimation = $ProjectileSprite

static var idCounter := -1

func _init() -> void:
	self.id = idCounter;
	idCounter -= 1; 

func _ready() -> void:
	projectileAnimation.play("default")
