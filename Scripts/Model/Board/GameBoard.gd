extends Node2D
class_name GameBoard

@export var xSize : int = 10
@export var ySize : int  = 10

@onready var starfighter = $Starfighter
@onready var tileMap = $TileMapLayer

const tileSize = 16
var boardCells : Array
var highlighters: Array[Node] = []
 

func _ready():
	spawnStarfighter(Vector2i(2, 2))
	for x in range(xSize):
		for y in range(ySize):
			var currentCell = Vector2i(x,y)
			boardCells.append(currentCell)
			tileMap.set_cell(currentCell,1,Vector2i(2,2))
	highlightTiles(boardCells)

	
	
func spawnStarfighter(coord: Vector2i):
	starfighter.setup(coord)
	starfighter.global_position = tileMap.map_to_local(coord)

	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mousePos = get_global_mouse_position()
		var gridPos = tileMap.local_to_map(mousePos)
		tryMoveStarfighter(gridPos)

	
func tryMoveStarfighter(dest: Vector2i):
	var reachable = getReachablePositions(starfighter.coord, starfighter.attributes["move"])

	if dest not in reachable:
		print("Destino fuera de rango")
		return

	moveStarfighter(dest)


func getReachablePositions(center: Vector2i, maxRange: int) -> Array:
	var result := []
	print(center)
	for x in range(maxRange):
		for y in range(maxRange):
			print("for: (", x,", ", y, ")")
			var d = abs(center.x - x) + abs(center.y - y)
			var currentCoord = Vector2i(x,y)
			if d <= maxRange && isOnBounds(currentCoord):
				result.append(currentCoord)
				print("append " , result)
	return result

#return true if the coord is on bounds
func isOnBounds(coord : Vector2i) -> bool:
	return coord.x >= 0 && coord.x < xSize && coord.y >= 0 && coord.y < ySize


func moveStarfighter(dest: Vector2i):
	clearHighlights()
	
	var start = starfighter.global_position
	var end = tileMap.map_to_local(dest)
	end.y = end.y + tileSize/2

	var tween = get_tree().create_tween()
	tween.tween_property(starfighter, "global_position", end, 0.25).set_ease(Tween.EASE_IN_OUT)

	starfighter.coord = dest

func highlightTiles(tiles: Array):
	clearHighlights()
	for t in tiles:
		var h := ColorRect.new()
		h.set_color(Color(0.5, 1.0, 1.0, 0.5))
		#h.global_position = gridToWorld(t) - Vector2(tile_size/2, tile_size/2)
		add_child(h)
		highlighters.append(h)

func clearHighlights():
	for h in highlighters:
		h.queue_free()
	highlighters.clear()
