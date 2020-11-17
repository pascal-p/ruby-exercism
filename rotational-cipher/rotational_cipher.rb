=begin
Write your code for the 'Rotational Cipher' exercise in this file. Make the tests in
`rotational_cipher_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/rotational-cipher` directory.
=end

module RotationalCipher
  extend self

  ROT13 = 13
  LEN_ALPHA = 26

  def rotate(txt, rot=self::ROT13)
    txt.split('').inject('') {|s, ch| s << rotate_ch(ch, rot)}

    ## alt:
    # s = ''
    # txt.each_char {|ch| s << rotate_ch(ch, rot) }
    # s
  end

  private

  def rotate_ch(ch, rot=self::ROT13)
    ## digit
    ch >= '0' && ch <= '9' && (return ch)

    och = ch.ord

    ## lowercase
    lo, hi = 'a'.ord, 'z'.ord
    (lo..hi).include?(och) && (return lo + (och - lo + rot) % self::LEN_ALPHA)

    ## uppercase
    lo, hi = 'A'.ord, 'Z'.ord
    (lo..hi).include?(och) && (return lo + (och - lo + rot) % self::LEN_ALPHA)

    ## punctuation, space
    /\A[',\.\?!";:\s]\z/.match?(ch) && (return ch)

    raise ArgumentError.new("[#{ch}] character is not yet managed!")
  end

end
