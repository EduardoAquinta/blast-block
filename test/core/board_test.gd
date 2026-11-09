extends GdUnitTestSuite

func test_new_board_is_eight_by_eight() -> void:
	var board: Board = Board.new()
	var size_of_board: Vector2i = board.size
	assert_that(size_of_board).is_equal(Vector2i(8, 8))

func test_on_new_board_that_cell_0_0_is_empty() -> void:
	var board: Board = Board.new()
	var cell_is_empty: bool = board.is_cell_empty(Vector2i(0, 0))
	assert_bool(cell_is_empty).is_true()

func test_filled_cell_is_not_empty() -> void:
	var board: Board = Board.new()
	board.fill_cell(Vector2i(0, 0))
	var cell_is_empty: bool = board.is_cell_empty(Vector2i(0, 0))
	assert_bool(cell_is_empty).is_false()

func test_2x1_shape_fills_two_adjacent_cells() -> void:
	var board: Board = Board.new()
	board.place_shape(Vector2i(0, 0), 2, Vector2i(0, 1))
	var first_cell_is_empty: bool = board.is_cell_empty(Vector2i(0,0))
	var second_cell_is_empty: bool = board.is_cell_empty(Vector2i(0,1))
	assert_bool(first_cell_is_empty).is_false()
	assert_bool(second_cell_is_empty).is_false()


