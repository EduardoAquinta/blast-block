extends GdUnitTestSuite
# Name each test for the behaviour it checks, not the method it calls.

# Test template: copy it, rename it, and fill in the three sections.
#
# func test_<behaviour_in_plain_words>() -> void:
# 	# Arrange: set up the objects and state the test needs
#
# 	# Act: do the ONE thing whose behaviour you are checking
#
# 	# Assert: check ONE outcome
# 	pass
#
func test_new_board_is_eight_by_eight() -> void:
	var board: Board = Board.new()
	var size_of_board: Vector2i = board.size
	assert_that(size_of_board).is_equal(Vector2i(8,8))

func test_on_new_board_that_square_0_0_is_empty() -> void:
	var board: Board = Board.new()
	var cell_is_empty: bool = board.is_cell_empty(Vector2i(0, 0))
	assert_bool(cell_is_empty).is_true()


