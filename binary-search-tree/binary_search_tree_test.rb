require 'minitest/autorun'
require_relative 'binary_search_tree'

class BSTTest < Minitest::Test
  def test_data_is_retained
    assert_equal 4, BST.new(4).data
  end

  def test_inserting_less
    # skip
    four = BST.new 4
    four.insert 2
    assert_equal 4, four.data
    assert_equal 2, four.left.data
  end

  def test_inserting_same
    # skip
    four = BST.new 4
    four.insert 4
    assert_equal 4, four.data
    assert_equal 4, four.left.data
  end

  def test_inserting_right
    # skip
    four = BST.new 4
    four.insert 5
    assert_equal 4, four.data
    assert_equal 5, four.right.data
  end

  def test_complex_tree
    # skip
    four = BST.new 4
    four.insert 2
    four.insert 6
    four.insert 1
    four.insert 3
    four.insert 7
    four.insert 5
    assert_equal 4, four.data
    assert_equal 2, four.left.data
    assert_equal 1, four.left.left.data
    assert_equal 3, four.left.right.data
    assert_equal 6, four.right.data
    assert_equal 5, four.right.left.data
    assert_equal 7, four.right.right.data
  end

  def record_all_data(bst)
    # all_data = []
    # bst.each { |data| all_data << data }
    # all_data
    bst.inject([]) {|a, e| a << e}
  end

  def test_iterating_one_element
    # skip
    assert_equal [4], record_all_data(BST.new(4))
  end

  def test_iterating_over_smaller_element
    # skip
    four = BST.new 4
    four.insert 2
    assert_equal [2, 4], record_all_data(four)

    four.insert 1
    assert_equal [1, 2, 4], record_all_data(four)
  end

  def test_iterating_over_larger_element
    # skip
    bst = BST.new 4
    bst.insert 5
    assert_equal [4, 5], record_all_data(bst)

    #
    bst.insert 8
    bst.insert 2
    assert_equal [2, 4, 5, 8], record_all_data(bst)
  end

  def test_iterating_over_complex_tree
    # skip
    bst = BST.new 4
    bst.insert 2
    bst.insert 1
    bst.insert 3
    bst.insert 6
    bst.insert 7
    bst.insert 5
    assert_equal [1, 2, 3, 4, 5, 6, 7], record_all_data(bst)
  end

  def test_each_returns_enumerator_if_no_block
    # skip

    tree = BST.new 4
    [2, 1, 3, 6, 7, 5].each { |x| tree.insert x }
    each_enumerator = tree.each

    assert_kind_of Enumerator, each_enumerator

    (1..7).each { |x| assert_equal(x, each_enumerator.next) }

    assert_raises(StopIteration) { each_enumerator.next }
  end

  def test_tree_from_array
    bst = BST.new [5, 4, 2, 10, 1, 8, 3, 9, 7, 6]
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], record_all_data(bst)
  end
end

