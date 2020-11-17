=begin
Write your code for the 'Atbash Cipher' exercise in this file. Make the tests in
`atbash_cipher_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/atbash-cipher` directory.
=end

module Atbash
  extend self

  ALPHA = 'a'..'z'
  NUM =  '0'..'9'
  ENC_MAP = (ALPHA.to_a + NUM.to_a).zip(ALPHA.to_a.reverse + NUM.to_a).inject({}) {|h, (k, v)| h[k]= v; h}.freeze
  DEC_MAP = ENC_MAP.inject({}) {|h, (k, v)| h[v] = k; h}.freeze
  GROUP = 5
  VALID_CH = /\A[a-z0-9]\z/

  def encode(txt)
    ary = txt.split('').
            map(&:downcase).
            select {|ch| /\A[a-z0-9]\z/.match?(ch)}.
            inject([]) {|a, ch| a << self::ENC_MAP[ch]}

    # grouping - more efficient to do grouping as we encode!
    0.step(ary.length, GROUP).inject('') do |s, ix|
      s << take_n(ary, ix).join() + ' '
    end.rstrip()
  end

  def decode(txt)
    txt.split('').
      map(&:downcase).
      select {|ch| /\A[a-z0-9]\z/.match?(ch)}.
      inject("") {|clear, ch| clear << self::DEC_MAP[ch]}
  end

  private

  def take_n(ary, from, n=GROUP)
    ary[from..from + n - 1]
  end

end

class AtbashKlass
  ALPHA = 'a'..'z'
  NUM =  '0'..'9'
  ENC_MAP = (ALPHA.to_a + NUM.to_a).zip(ALPHA.to_a.reverse + NUM.to_a).inject({}) {|h, (k, v)| h[k]= v; h}.freeze
  DEC_MAP = ENC_MAP.inject({}) {|h, (k, v)| h[v] = k; h}.freeze
  GROUP = 5
  VALID_CH = /\A[a-z0-9]\z/

  class << self

    def encode(txt)
      s, enc_grp = '', ''

      txt.each_char do |ch|
        ch.downcase!
        /\A[a-z0-9]\z/.match?(ch) || next

        if enc_grp.length < self::GROUP
          enc_grp << self::ENC_MAP[ch]
        else
          s << enc_grp + " "
          enc_grp = "" + self::ENC_MAP[ch] # reset - avoid  enc_grp = self::ENC_MAP[ch]...
          #                                # ... as it creates a reference => mutate the hash!
        end

      end

      # last group
      enc_grp.length > 0 && (s << enc_grp)

      s.rstrip
    end

    def decode(txt)
      txt.split('').
        map(&:downcase).
        select {|ch| /\A[a-z0-9]\z/.match?(ch)}.
        inject("") {|clear, ch| clear << self::DEC_MAP[ch]}
    end

  end

end
