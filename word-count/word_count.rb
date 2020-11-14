=begin
Write your code for the 'Word Count' exercise in this file. Make the tests in
`word_count_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/word-count` directory.
=end

class WordCount

  SEP_RE = /[\s,;:\.]+/
  NON_ALPHA_RE = /\A\W+|\W+\Z/

  attr_reader :phrase, :word_count

  def initialize(phrase)
    @phrase = phrase
    @word_count = wc(phrase)
  end

  private

  # wc(phrase)
  # takes a sentence
  #  - split it, filter non char, downcase and count with one FP pipeline
  #
  # returns a hash of (word, count)
  def wc(phrase)
    phrase.
      split(SEP_RE).
      map { |s| s.gsub(NON_ALPHA_RE, '').downcase }.
      select { |s| s.length > 0 }.
      inject({}) { |h, w| h[w] = h.fetch(w, 0) + 1; h }
  end

end
