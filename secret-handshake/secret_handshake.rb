=begin
Write your code for the 'Secret Handshake' exercise in this file. Make the tests in
`secret_handshake_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/secret-handshake` directory.
=end

class SecretHandshake
  SEC_HSHAKE_CODE =  { 1 => 'wink', 2 => 'double blink', 4 => 'close your eyes', 8 => 'jump', 16 => 'reverse' }
  BASE = SEC_HSHAKE_CODE.keys().inject([]) {|a, k| a << k}.sort{|a, b| b <=> a}

  def initialize(value)
    value.is_a?(Integer) || raise(ArgumentError.new("value should be a non negative integer"))
    value >= 0 || raise(ArgumentError.new("value should be non negative"))

    @value = value
  end

  def commands
    @commands ||= process
  end

  class << self

    def commands(value)
      new(value).commands
    end

  end

  private

  def process
    value, actions = @value, []

    (value == 0 || value % 16 == 0) && (return actions);

    ix, method = 1, :unshift
    value, method = case_16(value, method)

    ## other cases, keys: 8, 4, 2, 1...
    while value >= 1
      count = 0

      if value >= BASE[ix]
        value -= BASE[ix];
        count += 1
      end

      ix += 1

      if count > 0
        action = SEC_HSHAKE_CODE[BASE[ix - 1]]
        actions.public_send(method, action)
      end
    end

    actions
  end

  ## case with 16 - highest key
  def case_16(value, method)
    count = 0

    while value >= BASE[0]
      value -= BASE[0];
      count += 1
    end

    count % 2 == 1 && (method = :push)

    [value, method]
  end

end
