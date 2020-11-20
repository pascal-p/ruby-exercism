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
    r = fill(@msg)               ## fill the rails

    ## now, encode
    enum_rails.
      inject([]) {|a, jx| a << r[jx].select {|ch| ch != DEFL}}.
      join("")
  end

  def decode()
    ## 0 - prep. with placeholder ?
    msg_ph = '?' * @msg.length
    r = fill(msg_ph)

    ## 1 - repl. placeholder
    lix, ix = 0, 0
    each_rails do |jx|
      while ix < r[jx].length do
        if r[jx][ix] == '?'
          r[jx][ix] = @msg[lix]
          lix += 1
        end
        ix += 1
      end
      ix = 0 # reset
    end

    ## 2 - construct decoded message
    decoded = []

    0.upto(r[0].length - 1) do |ix|  ## assume all r have same lengths (take r[0]) and read column by column
      each_rails do |jx|
        unless r[jx][ix] == '.'
          decoded.append(r[jx][ix])
          break                      ## early exit
        end
      end
    end

    decoded.join('')
  end

  private

  def each_rails
    0.upto(@rails - 1) {|jx| yield jx if block_given?}
  end

  def enum_rails
    (0...@rails)
  end

  def fill(msg, defl=DEFL)
    ##
    ## ex. "message to encode!", with @rails = 4
    ##  rails | m e s s a g e t o e n c o d e
    ##  -------------------------------------
    ##  r[0]  | m . . . . . e . . . . . o . .
    ##  r[1]  | . e . . . g . t . . . c . d .
    ##  r[2]  | . . s . a . . . o . n . . . e
    ##  r[3]  | . . . s . . . . . e . . . . .
    ##
    r = enum_rails.inject([]) {|a, _| a << []}

    kx, incr = 0, true
    msg.each_char do |l|
      each_rails do |jx|
        ix = incr ? jx :  @rails - 2 - jx
        r[ix].append(kx == ix ? l : defl)
      end
      kx, incr = incr ? incr_fn(kx, incr) : decr_fn(kx, incr)
    end

    r
  end

  def incr_fn(kx, incr)
    ##
    ## Calc. increasing sequence 0, 1 .. @rails - 1, ends at @rails - 2
    ##
    @rails == 1 && (return [0, incr])
    kx = (kx + 1) % @rails
    kx == 0 && (kx, incr = @rails - 2, false)
    [kx, incr]
  end

  def decr_fn(kx, incr)
    ##
    ## Calc. decreasing sequence @rails - 2..0, ends at 1
    ##
    @rails == 1 && (return [0, incr])
    kx -= 1
    kx == -1 && (kx, incr = 1, true)
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
