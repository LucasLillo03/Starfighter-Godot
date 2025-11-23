extends Spaceship
class_name Starfighter

var weapon : Weapon
var engine : StarfighterEngine
var armour : Armour
var currentEnergy : int
@onready var weaponSprite = $WeaponSprite
@onready var engineSprite = $EngineSprite
@onready var engineEffectSprite = $EngineSprite/EngineEffect

func _init() -> void:
	id = 0
	attributes = {
		"totalHealth": 140,
		"healthRegeneration": 3,
		"totalEnergy": 80,
		"energyRegeneration": 10,
		"armour": 4,
		"move": 8,
		"moveCost": 10,
		"vision": 10
	}
	weapon = AutoCannon.new()
	engine = BaseEngine.new()

func setup(coord: Vector2i):
	self.coord = coord

func _ready() -> void:
	currentHealth = attributes.get("totalHealth")
	currentEnergy = attributes.get("totalEnergy")
	engineEffectSprite.play(engine.idleAnimation)
	
func _physics_process(delta: float) -> void:
	weaponSprite.play(weapon.idleAnimation)

func move(destiny : Vector2):
	var start = global_position
	var endY = Vector2(start.x, destiny.y)
	#end.y = end.y + tileSize/2

	var tween = get_tree().create_tween()
	engineEffectSprite.play(engine.poweringAnimation)
	if (start.y != destiny.y): tween.tween_property(self, "global_position", endY, 0.25).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", destiny, 0.25).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	engineEffectSprite.play(engine.idleAnimation)

	
