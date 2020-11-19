=begin
Write your code for the 'Rail Fence Cipher' exercise in this file. Make the tests in
`rail_fence_cipher_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/rail-fence-cipher` directory.
=end

class RailFenceCipher
  NON_LETTERS = /[^a-zA-Z0-9]+/
  DEFL = '.'

  attr_reader :msg, :rails

  def initialize(msg, rails)
    self.class.checker?(msg, rails) || (return msg)
    @msg = rails == 1 ? msg : msg.gsub(NON_LETTERS, '')
    @rails = rails
  end

  def encode()
    @rails == 1 && (return @msg)
    r = fill(@msg)
    0.upto(@rails - 1).
      inject([]) {|a, jx| a << r[jx].select {|ch| ch != DEFL}}.
      join("")
  end

  def decode()
    # 0 - prep. with placeholder ?
    msg_ph = '?' * @msg.length
    r = fill(msg_ph)
    # 1 - repl. placeholder
    lix, ix = 0, 0
    0.upto(@rails - 1) do |jx|
      while ix < r[jx].length do
        if r[jx][ix] == '?'
          r[jx][ix] = @msg[lix]
          lix += 1
        end
        ix += 1
      end
      ix = 0 # reset
    end
    # 2 - construct decoded message
    decoded = []
    # assume all r have same lengths and read column by column
    0.upto(r[0].length - 1) do |ix|
      0.upto(@rails - 1) do |jx|
        if r[jx][ix] != '.'
          decoded.append(r[jx][ix])
          break
        end
      end
    end
    #
    return decoded.join('')
  end

  private

  def fill(msg, defl=DEFL)
    r = 0.upto(@rails - 1).inject([]) {|a, _| a << []}
    kx, incr = 0, true

    msg.each_char do |l|
      0.upto(@rails - 1) do |jx|
        if incr
          r[jx].append(kx == jx ? l : defl)
        else
          ix = @rails - 2 - jx
          r[ix].append(kx == ix ? l : defl)
        end
      end
      kx, incr = incr ? incr_fn(kx, incr) : decr_fn(kx, incr)
    end

    r
  end

  def incr_fn(kx, incr)
    @rails == 1 && (return [0, incr])
    kx = (kx + 1) % @rails
    if kx == 0
      kx = @rails - 2
      incr = false
    end
    [kx, incr]
  end

  def decr_fn(kx, incr)
    @rails == 1 && (return [0, incr])
    kx -= 1
    if kx == -1
        kx = 1
        incr = true
    end
    [kx, incr]
  end

  class << self

    def checker?(msg, rails)
      msg.length == 0 && (return false)

      rails > msg.length && (return false)

      rails <= 0 &&
        raise(ArgumentError.new("rails should be positive"))

      true
    end

    def encode(msg, rails)
      checker?(msg, rails) || (return msg)
      self.new(msg, rails).encode
    end

    def decode(msg, rails)
      checker?(msg, rails) || (return msg)
      self.new(msg, rails).decode
    end

  end

end
