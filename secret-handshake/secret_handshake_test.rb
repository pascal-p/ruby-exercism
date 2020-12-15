require 'minitest/autorun'
require_relative 'secret_handshake'

class SecretHandshakeTest < Minitest::Test
  def test_handshake_1_to_wink
    handshake = SecretHandshake.new(1)
    assert_equal ['wink'], handshake.commands
  end

  def test_handshake_10_to_double_blink
    # skip
    handshake = SecretHandshake.new(2)
    assert_equal ['double blink'], handshake.commands
  end

  def test_handshake_100_to_close_your_eyes
    # skip
    handshake = SecretHandshake.new(4)
    assert_equal ['close your eyes'], handshake.commands
  end

  def test_handshake_100_to_close_your_eyes_alt
    # skip
    assert_equal ['close your eyes'], SecretHandshake.commands(4)
  end

  def test_handshake_1000_to_jump
    # skip
    handshake = SecretHandshake.new(8)
    assert_equal ['jump'], handshake.commands
  end

  def test_handshake_11_to_wink_and_double_blink
    # skip
    handshake = SecretHandshake.new(3)
    assert_equal ['wink', 'double blink'], handshake.commands
  end

  def test_handshake_10011_to_double_blink_and_wink
    # skip
    handshake = SecretHandshake.new(19)
    assert_equal ['double blink', 'wink'], handshake.commands
  end

  def test_handshake_11111_to_double_blink_and_wink
    # skip
    handshake = SecretHandshake.new(31)
    expected = ['jump', 'close your eyes', 'double blink', 'wink']
    assert_equal expected, handshake.commands
  end

  def test_handshake_1000001_to_double_blink_and_wink
    # skip
    expected = ['wink']
    assert_equal expected, SecretHandshake.commands(65)
  end

  def test_handshake_111111_to_double_blink_and_wink
    # skip
    expected = ['jump', 'close your eyes', 'double blink', 'wink']
    assert_equal expected, SecretHandshake.commands(63)
  end

  def test_invalid_handshake
    # skip
    assert_raises ArgumentError do
      SecretHandshake.new('piggies')
    end

    assert_raises ArgumentError do
      SecretHandshake.new(-10)
    end

    assert_raises ArgumentError do
      SecretHandshake.new(1.414)
    end
  end
end
