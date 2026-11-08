extends GdUnitTestSuite

func test_new_board_is_eight_by_eight() -> void:
	var board: Board = Board.new()
	var size_of_board: Vector2i = board.size
	assert_that(size_of_board).is_equal(Vector2i(8, 8))

func test_on_new_board_that_cell_0_0_is_empty() -> void:
	var board: Board = Board.new()
	var cell_is_empty: bool = board.is_cell_empty(Vector2i(0, 0))
	assert_bool(cell_is_empty).is_true()

func test_a_single_cell_shape_is_on_the_board() -> void:
	var board: Board = Board.new()
	var cell_is_full: bool = board.is_cell_empty(Vector2i(0, 0))
	assert_bool(cell_is_full).is_false()
