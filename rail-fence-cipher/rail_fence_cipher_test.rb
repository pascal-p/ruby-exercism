require 'minitest/autorun'
require_relative 'rail_fence_cipher'

class RailFenceCipherTest < Minitest::Test
  ## Encode portion
  def test_encode_with_empty_string
    assert_equal '', RailFenceCipher.encode('', 4)
  end

  def test_encode_with_one_rail
    # skip
    assert_equal 'One rail, only one rail',
                 RailFenceCipher.encode('One rail, only one rail', 1)
  end

  def test_encode_with_two_rails
    # skip
    assert_equal 'XXXXXXXXXOOOOOOOOO',
                 RailFenceCipher.encode('XOXOXOXOXOXOXOXOXO', 2)
  end

  def test_encode_with_three_rails
    # skip
    assert_equal 'WECRLTEERDSOEEFEAOCAIVDEN',
                 RailFenceCipher.encode('WEAREDISCOVEREDFLEEATONCE', 3)
  end

  def test_encode_with_ending_in_the_middle
    # skip
    assert_equal 'ESXIEECSR', RailFenceCipher.encode('EXERCISES', 4)
  end

  def test_encode_with_less_letters_than_rails
    # skip
    assert_equal 'More rails than letters',
                 RailFenceCipher.encode('More rails than letters', 24)
  end

  def test_encode_with_five_rails
    assert_equal 'FOOSBRA',
                 RailFenceCipher.encode('FOOBARS', 5)
    assert_equal 'TIehlsDteiIeaDvnhiseTl',
                 RailFenceCipher.encode('The Devil Is In The Details.', 5)
  end

  ## Decode portion
  def test_decode_with_empty_string
    # skip
    assert_equal '', RailFenceCipher.decode('', 4)
  end

  def test_decode_with_one_rail
   # skip
   assert_equal 'ABCDEFGHIJKLMNOP',
                RailFenceCipher.decode('ABCDEFGHIJKLMNOP', 1)
  end

  def test_decode_with_two_rails
    # skip
    assert_equal 'XOXOXOXOXOXOXOXOXO',
                 RailFenceCipher.decode('XXXXXXXXXOOOOOOOOO', 2)
  end

  def test_decode_with_three_rails
    # skip
    assert_equal 'THEDEVILISINTHEDETAILS',
                 RailFenceCipher.decode('TEITELHDVLSNHDTISEIIEA', 3)
  end

  def test_decode_with_six_rails
    assert_equal '112358132134558914423337761098715972584418167651094617711286',
                 RailFenceCipher.decode('133714114238148966225439541018335470986172518171757571896261', 6)
  end

  ## Encode / Decode identity
  def test_encode_decode_identity
    [["XOXOXOXOXOXOXOXOXO", 2],
     ["WEAREDISCOVEREDFLEEATONCE", 3],
     ["THEDEVILISINTHEDETAILS", 3],
     ["THEDEVILISINTHEDETAILS", 5],
     ["133714114238148966225439541018335470986172518171757571896261", 6]].each do |msg, rails|
      assert_equal msg,
                   RailFenceCipher.decode(RailFenceCipher.encode(msg, rails), rails)
    end
  end

end
