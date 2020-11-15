require 'minitest/autorun'
require_relative 'rna_transcription'

# Common test data version: 1.3.0 294c831
class RnaTranscriptionTest < Minitest::Test
  def test_empty_rna_sequence
    # skip
    assert_equal '', Complement.of_dna('')
  end

  def test_rna_complement_of_cytosine_is_guanine
    # skip
    assert_equal 'G', Complement.of_dna('C')
  end

  def test_rna_complement_of_guanine_is_cytosine
    # skip
    assert_equal 'C', Complement.of_dna('G')
  end

  def test_rna_complement_of_thymine_is_adenine
    # skip
    assert_equal 'A', Complement.of_dna('T')
  end

  def test_rna_complement_of_adenine_is_uracil
    # skip
    assert_equal 'U', Complement.of_dna('A')
  end

  def test_rna_complement
    # skip
    assert_equal 'UGCACCAGAAUU', Complement.of_dna('ACGTGGTCTTAA')
  end

  def test_more
    assert_equal('UGCACCAGAAUU',
                 Complement.of_dna('ACGTGGTCTTAA'))

    assert_equal('UCGAAAAGUAAGACUGACGUUGCCCGUUAUACAGAGACACACCUAAUUUUUUUCUCACAGACUAUCGUCG',
                 Complement.of_dna('AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'))
  end

  def test_error_on_non_dna_nucleotide
    assert_raises(ArgumentError) do
      Complement.of_dna('ATAZATAWATAQ')
    end
  end

end
