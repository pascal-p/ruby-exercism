require 'minitest/autorun'
require_relative 'atbash_cipher'

# Common test data version: 1.2.0 d5238bd
class AtbashCipherTest < Minitest::Test

  [Atbash, AtbashKlass].each do |klass|
     define_method("test_encode_yes_#{klass}") do
      # skip
      plaintext = 'yes'
      ciphertext = 'bvh'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_encode_no_#{klass}") do
      # skip
      plaintext = 'no'
      ciphertext = 'ml'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_encode_omg_#{klass}") do
      # skip
      plaintext = 'OMG'
      ciphertext = 'lnt'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_encode_spaces_#{klass}") do
      # skip
      plaintext = 'O M G'
      ciphertext = 'lnt'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_encode_mindblowingly_#{klass}") do
      # skip
      plaintext = 'mindblowingly'
      ciphertext = 'nrmwy oldrm tob'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_encode_numbers_#{klass}") do
      # skip
      plaintext = 'Testing,1 2 3, testing.'
      ciphertext = 'gvhgr mt123 gvhgr mt'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_encode_deep_thought_#{klass}") do
      # skip
      plaintext = 'Truth is fiction.'
      ciphertext = 'gifgs rhurx grlm'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_encode_all_the_letters_#{klass}") do
      # skip
      plaintext = 'The quick brown fox jumps over the lazy dog.'
      ciphertext = 'gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt'
      assert_equal ciphertext, klass.encode(plaintext)
    end

    define_method("test_decode_exercism_#{klass}") do
      # skip
      ciphertext = 'vcvix rhn'
      plaintext = 'exercism'
      assert_equal plaintext, klass.decode(ciphertext)
    end

    define_method("test_decode_a_sentence_#{klass}") do
      # skip
      ciphertext = 'zmlyh gzxov rhlug vmzhg vkkrm thglm v'
      plaintext = 'anobstacleisoftenasteppingstone'
      assert_equal plaintext, klass.decode(ciphertext)
    end

    define_method("test_decode_numbers_#{klass}") do
      # skip
      ciphertext = 'gvhgr mt123 gvhgr mt'
      plaintext = 'testing123testing'
      assert_equal plaintext, klass.decode(ciphertext)
    end

    define_method("test_decode_all_the_letters_#{klass}") do
      # skip
      ciphertext = 'gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt'
      plaintext = 'thequickbrownfoxjumpsoverthelazydog'
      assert_equal plaintext, klass.decode(ciphertext)
    end

    define_method("test_decode_with_too_many_spaces_#{klass}") do
      # skip
      ciphertext = 'vc vix    r hn'
      plaintext = 'exercism'
      assert_equal plaintext, klass.decode(ciphertext)
    end

    define_method("test_decode_with_no_spaces_#{klass}") do
      # skip
      ciphertext = 'zmlyhgzxovrhlugvmzhgvkkrmthglmv'
      plaintext = 'anobstacleisoftenasteppingstone'
      assert_equal plaintext, klass.decode(ciphertext)
    end
  end

end
