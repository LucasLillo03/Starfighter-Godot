extends Weapon
class_name AutoCannon

func _init() -> void:
	self.shotCost = 10
	self.damage = 20 
	self.velocity = 2
	self.idleAnimation = "idleAutoCannon"
	self.fireAnimation = "fireAutoCannon"
	
func fire(owner) -> Array[Projectile]:
	var position1 = Vector2i(1, 1);
	var position2 = Vector2i(1, -1);
	var resultList :Array[Projectile] = []
	var projectileScene = preload("res://Scenes/Projectile.tscn")
	
	var projectile1 = projectileScene.instantiate()
	projectile1.damage = damage
	projectile1.velocity = velocity
	projectile1.coord = owner.coord + position1 
	
	var projectile2 = projectileScene.instantiate()
	projectile2.damage = damage
	projectile2.velocity = velocity
	projectile2.coord = owner.coord + position2 
	
	resultList.append(projectile1)
	resultList.append(projectile2)
	
	return resultList
	
