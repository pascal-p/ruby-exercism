=begin
Write your code for the 'Difference Of Squares' exercise in this file. Make the tests in
`difference_of_squares_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/difference-of-squares` directory.
=end

class Squares

  def initialize(n)
    @n = n
  end

  def sum_of_squares()
    x1, x2, x3 = @n, @n + 1, (@n << 1) + 1 # 2 * n + 1
    s = (x1 * x2 * x3) >> 1
    s.div(3)
  end

  def square_of_sum
    x1, x2 = @n, @n + 1
    x = (x1 * x2) >> 1
    x * x
  end

  def difference
    square_of_sum - sum_of_squares
  end

end
