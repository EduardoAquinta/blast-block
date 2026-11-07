extends GdUnitTestSuite
## Tests for res://src/core/board.gd
##
## Every function whose name starts with `test_` is run by gdUnit4.
## Name each test for the behaviour it checks, not the method it calls.


# Optional hooks (delete any you don't need):
#   before()       runs once before all tests in this file
#   before_test()  runs before EACH test (fresh state for every test)
#   after_test()   runs after EACH test
#   after()        runs once after all tests


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
