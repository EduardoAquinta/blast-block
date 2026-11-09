class_name Board

extends RefCounted

var size: Vector2i = Vector2i(8, 8)

var _filled_cells: Array[Vector2i] = []

func fill_cell(cell: Vector2i) -> void:
	_filled_cells.append(cell)


func is_cell_empty(cell: Vector2i) -> bool:
	return not _filled_cells.has(cell)
