=begin
Write your code for the 'Rna Transcription' exercise in this file. Make the tests in
`rna_transcription_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/rna-transcription` directory.
=end

class Complement

  DNA_NUC = ['A', 'C', 'G', 'T']
  RNA_NUC = ['U', 'G', 'C', 'A']
  MAP_DNA_RNA = DNA_NUC.zip(RNA_NUC).inject({}) { |h, (d, r)| h[d] = r; h }

  class << self

    def of_dna(s)
      s.split('').inject('') do |str, ch|
        !DNA_NUC.index(ch) && raise(ArgumentError.new("unexpected dna nucleotide: #{ch}"))

        str << MAP_DNA_RNA[ch]
      end
    end

  end

end
