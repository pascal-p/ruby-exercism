require 'minitest/autorun'
require_relative 'difference_of_squares'

# Common test data version: 1.2.0 1b6851d
class DifferenceOfSquaresTest < Minitest::Test
  def test_square_of_sum_1
    # skip
    assert_equal 1, Squares.new(1).square_of_sum
  end

  def test_square_of_sum_5
    # skip
    assert_equal 225, Squares.new(5).square_of_sum
  end

  def test_square_of_sum_100
    # skip
    assert_equal 25_502_500, Squares.new(100).square_of_sum
  end

  def test_sum_of_squares_1
    # skip
    assert_equal 1, Squares.new(1).sum_of_squares
  end

  def test_sum_of_squares_5
    # skip
    assert_equal 55, Squares.new(5).sum_of_squares
  end

  def test_sum_of_squares_100
    # skip
    assert_equal 338_350, Squares.new(100).sum_of_squares
  end

  def test_difference_of_squares_1
    # skip
    assert_equal 0, Squares.new(1).difference
  end

  def test_difference_of_squares_5
    # skip
    assert_equal 170, Squares.new(5).difference
  end

  def test_difference_of_squares_100
    # skip
    assert_equal 25_164_150, Squares.new(100).difference
  end

  [[1_000_000, 250000166666416666500000],
   [4_000_000, 64000010666662666666000000],
   [9_000_000_000, 1640250000121499999979749999998500000000],
   [9_000_000_000_000_000, 1640250000000000121499999999999979749999999999998500000000000000]].each do |n, exp|

    define_method("test_difference_of_squares_#{n}") do
      assert_equal exp, Squares.new(n).difference
    end
  end

end
