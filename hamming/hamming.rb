=begin
Write your code for the 'Hamming' exercise in this file. Make the tests in
`hamming_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/hamming` directory.
=end

class Hamming
  ALPHA = ['A', 'C', 'G', 'T']
  ALPHA_RE = /\A[#{ALPHA.join()}]*\Z/

  class << self
    def compute(a, b)
      validate(a, b)

      a == b && (return 0)

      a.split('').
        zip(b.split('')).
        map { |ch1, ch2|  ch1 == ch2 ? 0 : 1 }.
        inject(0) {|s, x| s += x }
    end

    def compute_alt(a, b)
      validate(a, b)

      a == b && (return 0)

      # a.split('').
      #   zip(b.split('')).
      #   map { |ch1, ch2|  ch1 == ch2 ? 0 : 1 }.
      #  reduce(:+)

      a.split('').
        zip(b.split('')).
        inject([]) {|ary, (ch1, ch2)| ary << (ch1 == ch2 ? 0 : 1); ary }.
        reduce(:+)
    end

    def validate(a, b)
      a.length() != b.length() && raise(ArgumentError.new("Required two strings of same length"))

      (check(a) && check(b)) || raise(ArgumentError.new("Expected alphabet is #{ALPHA}"))
    end

    def check(s)
      ALPHA_RE.match?(s)
    end

  end

end
