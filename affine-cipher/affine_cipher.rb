=begin
Write your code for the 'Affine Cipher' exercise in this file. Make the tests in
`affine_cipher_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/affine-cipher` directory.
=end

class Affine
  ALPHA = 'a'..'z' # "abcdefghijklmnopqrstuvwxyz"
  M = ALPHA.count
  L2IX = ALPHA.zip((0...M)).inject({}) {|h, (k, v)| h[k] = v; h}
  IX2L = L2IX.inject({}) {|h, (k, v)| h[v] = k; h}
  NON_ALPHA_REXP = /[^a-zA-Z0-9]/
  GRP_SIZE = 5 + 1

  def initialize(α, β)
    check(α)
    @α = α
    @β = β
  end

  def encode(txt)
    pipeline(txt, @α, :+).
      inject(' ') {|s, ch| s << grouping(s, ch)}.
      strip
  end

  def decode(txt)
    α = xgcd(@α, self.class::M)[1]
    check(α)

    pipeline(txt, α, :-).join()
  end

  # for convenience
  class << self
    for m in [:encode, :decode]
      define_method(m) do |txt, α, β|
        new(α, β).public_send(__method__, txt)
      end
    end
  end

  private
  def pipeline(src, α, op=:+)
    src.each_char.
      select {|c| !self.class::NON_ALPHA_REXP.match?(c)}.
      map {|c| translate(c, α, op)}
  end

  def translate(c, α, op)
    c >= '0' && c <= '9' && (return c)

    klass = self.class
    op == :+ ? klass::IX2L[(α * klass::L2IX[c.downcase] + @β) % klass::M] :
       klass::IX2L[(α * (klass::L2IX[c.downcase] - @β) % klass::M)]
  end

  def grouping(s, ch)
    l = s.length + 1
    l % self.class::GRP_SIZE == 0 ? ch + ' ' : ch # s + ch + ' ' : s + ch
  end

  def is_coprime?(α)
    α.gcd(self.class::M) == 1
  end

  def check(α)
    is_coprime?(α) || raise(ArgumentError.new("#{α} and ${self.class::M} are not coprime"))
  end

  def xgcd(x, y)
    x₀, x₁, y₀, y₁ = 0, 1, 1, 0

    while x != 0 do
      (q, x), y = y.divmod(x), x
      y₀, y₁ = y₁, y₀ - q * y₁
      x₀, x₁ = x₁, x₀ - q * x₁
    end

    [y, x₀, y₀]
  end

end
