extends GameElement
class_name Projectile 

@export var damage : int
@export var velocity : int 
static var idCounter := -1

func _init() -> void:
	self.id = idCounter;
	idCounter -= 1; 
