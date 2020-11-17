require 'minitest/autorun'
require_relative 'nucleotide_count'

class NucleotideTest < Minitest::Test

  for klass in [Nucleotide, NucleotideAlt]

    define_method("test_empty_dna_strand_has_no_adenosine_#{klass}") do
      assert_equal 0, klass.from_dna('').count('A')
    end

    define_method("test_repetitive_cytidine_gets_counted_#{klass}") do
      # skip
      assert_equal 5, klass.from_dna('CCCCC').count('C')
    end

    define_method("test_counts_only_thymidine#{klass}") do
      # skip
      assert_equal 1, klass.from_dna('GGGGGTAACCCGG').count('T')
    end

    define_method("test_counts_a_nucleotide_only_once#{klass}") do
      # skip
      dna = klass.from_dna('CGATTGGG')
      dna.count('T')
      dna.count('T')
      assert_equal 2, dna.count('T')
    end

    define_method("test_empty_dna_strand_has_no_nucleotides#{klass}") do
      # skip
      expected = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
    assert_equal expected, klass.from_dna('').histogram
    end

    define_method("test_repetitive_sequence_has_only_guanosine#{klass}") do
      # skip
      expected = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 8 }
      assert_equal expected, klass.from_dna('GGGGGGGG').histogram
    end

    define_method("test_counts_all_nucleotides#{klass}") do
      # skip
      s = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
      dna = klass.from_dna(s)
      expected = { 'A' => 20, 'T' => 21, 'G' => 17, 'C' => 12 }
      assert_equal expected, dna.histogram
    end

    define_method("test_validates_dna#{klass}") do
      # skip
      assert_raises ArgumentError do
        klass.from_dna('JOHNNYAPPLESEED')
      end
    end
  end

end
