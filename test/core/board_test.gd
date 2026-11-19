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
	var single_cell_shape: Array[Vector2i] = [Vector2i(0,0)]
	var position: Vector2i = Vector2i(0, 0)
	board.place_shape(single_cell_shape, position)
	var cell_is_empty: bool = board.is_cell_empty(Vector2i(0, 0))
	assert_bool(cell_is_empty).is_false()

@warning_ignore("unused_parameter")
func test_a_shape_fills_the_correct_board_cells(
	position: Vector2i,
	expected_first_cell: Vector2i,
	expected_second_cell: Vector2i,
	test_parameters := [
		# position         expected first     expected second
		[Vector2i(2, 5), Vector2i(2, 5), Vector2i(2, 6)],  # x and y differ: catches a swapped anchor
		[Vector2i(5, 1), Vector2i(5, 1), Vector2i(5, 2)],  # x and y differ the other way round
		[Vector2i(6, 6), Vector2i(6, 6), Vector2i(6, 7)],  # second cell lands on the last row
	]
) -> void:
	var board: Board = Board.new()
	var two_cell_shape: Array[Vector2i] = [Vector2i(0, 0), Vector2i(0, 1)]
	board.place_shape(two_cell_shape, position)
	var first_cell_is_empty: bool = board.is_cell_empty(expected_first_cell)
	var second_cell_is_empty: bool = board.is_cell_empty(expected_second_cell)
	assert_bool(first_cell_is_empty).is_false()
	assert_bool(second_cell_is_empty).is_false()

func test_a_shape_cannot_be_placed_off_the_board() -> void:
	var board: Board = Board.new()
	var single_cell_shape: Array[Vector2i] = [Vector2i(0, 0)]
	var position: Vector2i = Vector2i(8, 8)
	var can_place_piece: bool = board.can_place(single_cell_shape, position)
	assert_bool(can_place_piece).is_false()

func test_a_shape_can_be_placed_on_the_board() -> void:
	var board: Board = Board.new()
	var single_cell_shape: Array[Vector2i] = [Vector2i(0, 0)]
	var position: Vector2i = Vector2i(7, 7)
	var can_place_piece: bool = board.can_place(single_cell_shape, position)
	assert_bool(can_place_piece).is_true()

func test_a_shape_on_and_off_the_board_is_off_the_board() -> void:
	var board: Board = Board.new()
	var two_cell_shape: Array[Vector2i] = [Vector2i(0, 0), Vector2i(1,0)]
	var position: Vector2i = Vector2i(7, 7)
	var can_place_piece: bool = board.can_place(two_cell_shape, position)
	assert_bool(can_place_piece).is_false()

func test_a_shape_at_position_0_0_is_on_the_board() -> void:
	var board: Board = Board.new()
	var single_cell_shape: Array[Vector2i] = [Vector2i(0, 0)]
	var position: Vector2i = Vector2i(0, 0)
	var can_place_piece: bool = board.can_place(single_cell_shape, position)
	assert_bool(can_place_piece).is_true()

func test_a_shape_with_a_negative_position_cannot_be_placed_on_the_board() -> void:
	var board: Board = Board.new()
	var l_shape: Array[Vector2i] = [Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(1, 2)]
	var position: Vector2i = Vector2i(-1, 0)
	var can_place_l_shape: bool = board.can_place(l_shape, position)
	assert_bool(can_place_l_shape).is_false()

func test_place_shape_returns_false_if_a_shape_with_a_negative_position_is_placed() -> void:
	var board: Board = Board.new()
	var single_cell_shape: Array[Vector2i] = [Vector2i(0, 0)]
	var position: Vector2i = Vector2i(-1, -1)
	var can_place_shape: bool = board.place_shape(single_cell_shape, position)
	assert_bool(can_place_shape).is_false()

func test_place_shape_returns_true_if_a_shape_with_an_accepted_position_is_placed() -> void:
	var board: Board = Board.new()
	var single_cell_shape: Array[Vector2i] = [Vector2i(0, 0)]
	var position: Vector2i = Vector2i(0, 0)
	var can_place_shape: bool = board.place_shape(single_cell_shape, position)
	assert_bool(can_place_shape).is_true()

func test_refused_placement_leaves_the_board_unchanged() -> void:
	var board: Board = Board.new()
	var l_shape: Array[Vector2i] = [Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(1, 2)]
	var position: Vector2i = Vector2i(6, 6)
	board.place_shape(l_shape, position)
	var cell_is_empty: bool = board.is_cell_empty(position)
	assert_bool(cell_is_empty).is_true()

func test_a_shape_cannot_overlap_filled_cells() -> void:
	var board: Board = Board.new()
	var single_cell_shape: Array[Vector2i] = [Vector2i(0, 0)]
	var position: Vector2i = Vector2i(0, 0)
	board.place_shape(single_cell_shape, position)
	var place_second_shape: bool = board.place_shape(single_cell_shape, position)
	assert_bool(place_second_shape).is_false()

func test_can_place_will_refuse_an_overlap() -> void:
	var board: Board = Board.new()
	var single_cell_shape: Array[Vector2i] = [Vector2i(0, 0)]
	var position: Vector2i = Vector2i(0, 0)
	board.place_shape(single_cell_shape, position)
	var can_I_place_shape: bool = board.can_place(single_cell_shape, position)
	assert_bool(can_I_place_shape).is_false()

func test_a_complete_row_is_cleared_from_the_board() -> void:
	var board: Board = Board.new()
	var horizontal_shape: Array[Vector2i] = [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
	var position_one: Vector2i = Vector2i(0, 0)
	var position_two: Vector2i = Vector2i(4, 0)
	board.place_shape(horizontal_shape, position_one)
	board.place_shape(horizontal_shape, position_two)
	var cell_0_0_is_empty: bool = board.is_cell_empty(Vector2i(0, 0))
	var cell_4_0_is_empty: bool = board.is_cell_empty(Vector2i(4, 0))
	assert_bool(cell_0_0_is_empty).is_true()
	assert_bool(cell_4_0_is_empty).is_true()


