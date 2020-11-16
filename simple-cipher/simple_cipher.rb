require "securerandom"
=begin
Write your code for the 'Simple Cipher' exercise in this file. Make the tests in
`simple_cipher_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/simple-cipher` directory.
=end

#
# key    = "ddddddddddddddddd"  - meaing each letter is shifted to the right by 4
# input  = "iamapandabear"
# output = "ldpdsdqgdehdu"
#

class SimpleCipher
  ALPHA = 'a'..'z'
  LEN_ALPHA = (ALPHA).count
  HSH = ALPHA.zip(0...LEN_ALPHA).inject({}) {|h, (l, ix)| h[l] = ix; h}
  REV_HSH = HSH.inject({}) {|h, (k, v)| h[v] = k; h}

  attr_reader :key

  def initialize(key=nil)
    if key.nil?
      key = (1..100).inject("") {|s, _| s << self.class::REV_HSH[(SecureRandom.random_number * 26).to_i] }
    else
      validate(key)
    end
    @key = key
  end

  def key_len
    @key_len ||= @key.length
  end


  #
  # Assuming text to encode or decode is well-formed: only lowercase character
  #

  def encode(text)
    klass = self.class

    text.split('').each_with_index.inject("") do |cipher, (l, ix)|
      jx = klass::HSH[l] + klass::HSH[ @key[ix % key_len] ]
      cipher << klass::REV_HSH[jx % klass::LEN_ALPHA]
    end
  end

  def decode(text)
    klass = self.class

    text.split('').each_with_index.inject("") do |clear, (l, ix)|
      jx = klass::HSH[l] - klass::HSH[@key[ix % key_len]] % klass::LEN_ALPHA
      clear << klass::REV_HSH[jx % klass::LEN_ALPHA]
    end
  end

  private

  def validate(key)
    # valid key iff only composed of lowercase latin letter
    /\A[a-z]+\z/.match?(key) || raise(ArgumentError.new("Invalid key"))
  end

end
