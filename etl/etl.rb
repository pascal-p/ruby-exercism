=begin
Write your code for the 'ETL' exercise in this file. Make the tests in
`etl_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/etl` directory.
=end

class ETL

  class << self

    def transform(h)
      h.inject({}) {|h, (k, av)| av.inject(h) {|hn, x| hn[x.downcase] = k; hn}}
    end

  end

end