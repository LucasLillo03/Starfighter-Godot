extends Node2D
class_name GameEngine

@export var xSize : int = 30
@export var ySize : int  = 10

@onready var starfighter = $Starfighter
@onready var gameBoard = $GameBoard
@onready var moveButton = $CanvasLayer/Control/MoveButton

const tileSize = 16
var boardCells : Array
var highlighters: Array[Node] = []
var onMove := false
signal moveClick 
 

func _ready():
	spawnStarfighter(Vector2i(2, 2))
	clearBoard()

func _process(delta: float) -> void:
	if moveClick:
		if (onMove):
			clearBoard()
			updateRechable()
		else: 
			clearBoard()

func clearBoard():
	for x in range(xSize):
		for y in range(ySize):
			var currentCell = Vector2i(x,y)
			boardCells.append(currentCell)
			gameBoard.set_cell(currentCell,1,Vector2i(2,2))
			
func updateRechable():
	highlightTiles(getReachablePositions(starfighter.coord, starfighter.attributes["move"]))

func spawnStarfighter(coord: Vector2i):
	starfighter.setup(coord)
	starfighter.global_position = gameBoard.map_to_local(coord)

	
func _input(event):
	if event is InputEventMouseButton and event.pressed and onMove:
		var mousePos = get_global_mouse_position()
		var gridPos = gameBoard.local_to_map(mousePos)
		tryMoveStarfighter(gridPos)


	
func tryMoveStarfighter(dest: Vector2i):
	var reachable = getReachablePositions(starfighter.coord, starfighter.attributes["move"])

	if dest not in reachable:
		print("Destino fuera de rango")
		return

	moveStarfighter(dest)
	moveButton.button_pressed = false
	


func getReachablePositions(center: Vector2i, maxRange: int) -> Array:
	var result := []
	for x in range(center.x - maxRange, center.x + maxRange +1):
		for y in range(center.y - maxRange, center.y + maxRange +1):
			var d = abs(center.x - x) + abs(center.y - y)
			var currentCoord = Vector2i(x,y)
			if d <= maxRange && isOnBounds(currentCoord):
				result.append(currentCoord)
	return result

#return true if the coord is on bounds
func isOnBounds(coord : Vector2i) -> bool:
	return coord.x >= 0 && coord.x < xSize && coord.y >= 0 && coord.y < ySize


func moveStarfighter(dest: Vector2i):
	var start = starfighter.global_position
	var end = gameBoard.map_to_local(dest)
	
	starfighter.move(end)
	
	starfighter.coord = dest
	
	clearBoard()
	clearHighlights()

func highlightTiles(tiles: Array):
	clearHighlights()
	for t in tiles:
		gameBoard.set_cell(t, 1, Vector2i(3,2))
		highlighters.append(t)

func clearHighlights():
	for h in highlighters:
		h.queue_free()
	highlighters.clear()


func _on_move_button_toggled(toggled_on: bool) -> void:
	moveClick.emit()
	onMove = toggled_on
