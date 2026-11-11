class_name Board

extends RefCounted

var size: Vector2i = Vector2i(8, 8)

var _filled_cells: Array[Vector2i] = []

func place_shape(shape: Array[Vector2i], position: Vector2i) -> void:
	for offset in shape:
		fill_cell(offset + position)

func fill_cell(cell: Vector2i) -> void:
	_filled_cells.append(cell)

func is_cell_empty(cell: Vector2i) -> bool:
	return not _filled_cells.has(cell)

func can_place(shape: Array[Vector2i], position: Vector2i) -> bool:
	for offset in shape:
		if not _is_on_board(offset + position):
			return false
	return true

func _is_on_board(cell: Vector2i) -> bool:
	var x_on_board: bool = cell.x >= 0 and cell.x < size.x
	var y_on_board: bool = cell.y >= 0 and cell.y < size.y
	return x_on_board and y_on_board
