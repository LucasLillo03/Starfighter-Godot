extends Weapon
class_name AutoCannon

func _init() -> void:
	self.shotCost = 10
	self.damage = 20 
	self.velocity = 2
	self.idleAnimation = "idleAutoCannon"
	self.fireAnimation = "fireAutoCannon"
	
func fire(owner):
	var position1 = Vector2i(1, 1);
	var position2 = Vector2i(1, -1);
	owner.spawnProjectile(damage, velocity, position1);
	owner.spawnProjectile(damage, velocity, position2);
