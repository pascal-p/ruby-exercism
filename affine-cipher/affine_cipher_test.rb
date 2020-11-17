require 'minitest/autorun'
require_relative 'affine_cipher'

# Common test data version: 2.0.0 8026923
class AffineCipherTest < Minitest::Test
  def test_encode_yes
    # skip
    cipher = Affine.new(5, 7)
    plaintext = 'yes'
    ciphertext = 'xbt'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_no
    # skip
    cipher = Affine.new(15, 18)
    plaintext = 'no'
    ciphertext = 'fu'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_omg
    # skip
    cipher = Affine.new(21, 3)
    plaintext = 'OMG'
    ciphertext = 'lvz'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_o_m_g
    # skip
    cipher = Affine.new(25, 47)
    plaintext = 'O M G'
    ciphertext = 'hjp'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_mindblowingly
    # skip
    cipher = Affine.new(11, 15)
    plaintext = 'mindblowingly'
    ciphertext = 'rzcwa gnxzc dgt'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_numbers
    # skip
    cipher = Affine.new(3, 4)
    plaintext = 'Testing,1 2 3, testing.'
    ciphertext = 'jqgjc rw123 jqgjc rw'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_deep_thought
    # skip
    cipher = Affine.new(5, 17)
    plaintext = 'Truth is fiction.'
    ciphertext = 'iynia fdqfb ifje'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_all_the_letters
    # skip
    cipher = Affine.new(17, 33)
    plaintext = 'The quick brown fox jumps over the lazy dog.'
    ciphertext = 'swxtj npvyk lruol iejdc blaxk swxmh qzglf'
    assert_equal ciphertext, cipher.encode(plaintext)
  end

  def test_encode_with_a_not_coprime_to_m
    # skip
    assert_raises(ArgumentError) { Affine.new(6, 17) }
  end

  def test_decode_exercism
    # skip
    cipher = Affine.new(3, 7)
    ciphertext = 'tytgn fjr'
    plaintext = 'exercism'
    assert_equal plaintext, cipher.decode(ciphertext)
  end

  def test_decode_a_sentence
    # skip
    cipher = Affine.new(19, 16)
    ciphertext = 'qdwju nqcro muwhn odqun oppmd aunwd o'
    plaintext = 'anobstacleisoftenasteppingstone'
    assert_equal plaintext, cipher.decode(ciphertext)
  end

  def test_decode_numbers
    # skip
    cipher = Affine.new(25, 7)
    ciphertext = 'odpoz ub123 odpoz ub'
    plaintext = 'testing123testing'
    assert_equal plaintext, cipher.decode(ciphertext)
  end

  def test_decode_all_the_letters
    # skip
    cipher = Affine.new(17, 33)
    ciphertext = 'swxtj npvyk lruol iejdc blaxk swxmh qzglf'
    plaintext = 'thequickbrownfoxjumpsoverthelazydog'
    assert_equal plaintext, cipher.decode(ciphertext)
  end

  def test_decode_with_no_spaces_in_input
    # skip
    ciphertext = 'swxtjnpvyklruoliejdcblaxkswxmhqzglf'
    plaintext = 'thequickbrownfoxjumpsoverthelazydog'
    assert_equal plaintext, Affine.decode(ciphertext, 17, 33) # shorcut
  end

  def test_decode_with_too_many_spaces
    # skip
    ciphertext = 'vszzm    cly   yd cg    qdp'
    plaintext = 'jollygreengiant'
    assert_equal plaintext, Affine.decode(ciphertext, 15, 16) # shorcut
  end

  def test_decode_with_a_not_coprime_to_m
    # skip
    assert_raises(ArgumentError) { Affine.new(13, 5) }
  end

  def test_encode_long_str
    plaintext = "Chor. Two households, both alike in dignity,
In fair Verona, where we lay our scene,
From ancient grudge break to new mutiny,
Where civil blood makes civil hands unclean.
From forth the fatal loins of these two foes
A pair of star-cross'd lovers take their life;
Whose misadventur'd piteous overthrows
Doth with their death bury their parents' strife,
The fearful passage of their death-mark'd love,
And the continuance of their parents' rage,
Which, but their children's end, naught could remove,
Is now the two hours' traffic of our stage;
The which if you with patient ears attend,
What here shall miss, our toil shall strive to mend."

    ciphertext = "bixwe dxixv njixy snkxe ityzh jzgsz rgzel zgatz wmjwx gtdij wjdjy tlxvw nbjgj awxpt gbzjg erwvs rjkwj thexg jdpve zgldi jwjbz mzyky xxspt hjnbz mzyit gsnvg byjtg awxpa xweie ijate tyyxz gnxae ijnje dxaxj ntotz wxane twbwx nnsyx mjwne thjei jzwyz ajdix njpzn tsmjg evwso zejxv nxmjw eiwxd nsxei dzeie ijzws jteik vwlei jzwot wjgen newza jeija jtwav yotnn trjxa eijzw sjtei ptwhs yxmjt gseij bxgez gvtgb jxaei jzwot wjgen wtrjd izbik veeij zwbiz yswjg njgsg tvrie bxvys wjpxm jzngx deije dxixv wnewt aazbx axvwn etrje ijdiz bizal xvdze iotez jgejt wntee jgsdi teijw jnity ypznn xvwex zynit yynew zmjex pjgs"
    
    assert_equal ciphertext, Affine.encode(plaintext, 17, 19)
  end
end
