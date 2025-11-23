extends GameElement
class_name Projectile 

@export var damage : int
static var idCounter := -1

func _init(damage : int) -> void:
	self.id = idCounter;
	idCounter -= 1; 
	self.damage = damage; 
