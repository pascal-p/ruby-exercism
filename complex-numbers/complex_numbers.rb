=begin
Write your code for the 'Complex Numbers' exercise in this file. Make the tests in
`complex_numbers_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/complex-numbers` directory.
=end

class ComplexNumber
  EPS = 1e-7

  attr_reader :re, :im

  class << self

    def method_missing(mname, *args, &block)
      if mname == :call || mname == :"."
        self.new(*args)
      else
        raise(ArgumentError.new("Method `#{mname}` doesn't exist."))
      end
    end

    def respond_to?(mname, include_private=false)
      (mname == :call  || mname == :".") && (return true)
      super
    end
  end

  def initialize(real, imag)
    @re, @im = real, imag
  end

  def real
    @re
  end

  def imaginary
    @im
  end

  def conjugate
    self.class.new(@re, -@im)
  end

  def ==(other)
    cmp1 = if any_float?(@re, other.re)
             (@re - other.re).abs <= EPS
           else
             @re == other.re
           end

    cmp2 = if any_float?(@im, other.im)
             (@im - other.im).abs <= EPS
           else
             @im == other.im
           end

    cmp1 && cmp2
  end

  def +(other)
    self.class.new(@re + other.re, @im + other.im)
  end

  def -(other)
    self.class.new(@re - other.re, @im - other.im)
  end

  def *(other)
    a, b = to_tuple(self)
    c, d = to_tuple(other)
    self.class.new(a * c - b * d, b * c + a * d)
  end

  def /(other)
    a, b = to_tuple(self)
    c, d = to_tuple(other)
    den = c * c + d * d
    x = (a * c + b * d).fdiv(den)
    y = (b * c - a * d).fdiv(den)
    self.class.new(x, y)
  end

  def abs
    Math.sqrt(@re * @re + @im * @im)
  end

  def exp
    a = Math.exp(@re)
    x, y = Math.cos(@im), Math.sin(@im)
    self.class.new(a * x, a * y)
  end

  def to_s
    "#{@re} + #{@im}.i"
  end

  private

  def to_tuple(cn)
    [cn.re, cn.im]
  end

  def any_float?(x, y)
    x.class == Float || y.class == Float
  end

end
