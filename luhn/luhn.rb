=begin
Write your code for the 'Luhn' exercise in this file. Make the tests in
`luhn_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/luhn` directory.
=end

class Luhn

  class << self

    def valid?(s)
      ns = s.gsub(/[\s\t\r\n]+/, '')

      ns.length <= 1 && (return false)

      !(/\A\d+\Z/.match(ns)) && (return false)

      calc(ns.split('')) % 10 == 0
    end

    private

    def calc(a)
      parity = a.length % 2 == 0 ? 1 : 0

      # ix starts at 0
      res = a.each_with_index.inject([0, 0]) do |csum, (s, ix)|
        d = s.to_i

        if ix % 2 == parity
          csum[0] += d
        else
          d = 2 * d
          csum[1] += d > 9 ? d - 9 : d
        end

        csum
      end

      res[0] + res[1]
    end
  end

end
