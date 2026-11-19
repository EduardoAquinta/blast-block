class_name Board

extends RefCounted

var size: Vector2i = Vector2i(8, 8)

var _filled_cells: Array[Vector2i] = []

func place_shape(shape: Array[Vector2i], position: Vector2i) -> bool:
	if not can_place(shape, position):
		return false
	for offset in shape:
		_fill_cell(offset + position)
	if _is_row_full(0):
		_clear_row(0)
	return true

func _fill_cell(cell: Vector2i) -> void:
	_filled_cells.append(cell)

func is_cell_empty(cell: Vector2i) -> bool:
	return not _filled_cells.has(cell)

func _is_row_full(y: int) -> bool:
	for x in range(size.x):
		if is_cell_empty(Vector2i(x, y)):
			return false
	return true

func _clear_row(y: int) -> void:
	for x in range(size.x):
		_filled_cells.erase(Vector2i(x, y))

func can_place(shape: Array[Vector2i], position: Vector2i) -> bool:
	for offset in shape:
		var cell: Vector2i = offset + position
		if not _is_on_board(cell):
			return false
		if not is_cell_empty(cell):
			return false
	return true

func _is_on_board(cell: Vector2i) -> bool:
	var x_on_board: bool = cell.x >= 0 and cell.x < size.x
	var y_on_board: bool = cell.y >= 0 and cell.y < size.y
	return x_on_board and y_on_board
