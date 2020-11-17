=begin
Write your code for the 'Nucleotide Count' exercise in this file. Make the tests in
`nucleotide_count_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/nucleotide-count` directory.
=end

module Nucleotide
  extend self

  ALPHA = ['A', 'C', 'G', 'T']

  def from_dna(strand)
    !strand.match?(/\A[#{self::ALPHA.join('')}]*\z/) &&
      raise(ArgumentError.new("all letters must be in #{ALPHA}"))

    hsh = self::ALPHA.inject({}) {|h, k| h[k] = 0; h}
    @hsh = strand.upcase.split('').inject(hsh) {|h, ch| h[ch] += 1; h}
    self
  end

  def count(l)
    @hsh.has_key?(l.upcase) || raise(ArgumentError.new("letter must be in #{ALPHA}"))

    @hsh[l]
  end

  def histogram
    @hsh
  end
end


# Alt Impl
class NucleotideAlt
  ALPHA = ['A', 'C', 'G', 'T']

  class << self

    def from_dna(strand)
      !strand.match?(/\A[#{self::ALPHA.join('')}]*\z/) &&
        raise(ArgumentError.new("all letters must be in #{ALPHA}"))

      hsh = self::ALPHA.inject({}) {|h, k| h[k] = 0; h}
      @hsh = strand.upcase.split('').inject(hsh) {|h, ch| h[ch] += 1; h}
      self
    end

    def count(l)
      @hsh.has_key?(l.upcase) || raise(ArgumentError.new("letter must be in #{ALPHA}"))

      @hsh[l]
    end

    def histogram
      @hsh
    end

  end
end
