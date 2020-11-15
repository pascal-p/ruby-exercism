=begin
Write your code for the 'Run Length Encoding' exercise in this file. Make the tests in
`run_length_encoding_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/run-length-encoding` directory.
=end

class RunLengthEncoding

  class << self

    def encode(s)
      s.length == 0 && (return '')

      count, pch = 1, s[0]
      validate(pch)

      ns = s[1..-1].split('').inject("") do |str, cch|
        validate(cch)
        if cch == pch
          count += 1
        else
          str << (count > 1 ? count.to_s : '') + pch
          count, pch = 1, cch
        end

        str
      end

      ns << (count > 1 ? count.to_s : '') + pch
    end

    def decode(s)
      s.length == 0 && (return '')

      validate(s[-1])
      snum, num = '', 0

      s.split('').inject("") do |decstr, ch|
        if ('0'..'9').include?(ch)
          snum << ch

        elsif ('a'..'z').include?(ch.downcase) || ch == ' '
          if snum.length > 0
            decstr <<  ch * snum.to_i
            snum = ''
          else
            decstr << ch
          end

        else
          raise(ArgumentError.new('Not a valid character'))
        end

        decstr
      end
    end

    def validate(ch)
      ch = ch.downcase

      (ch < 'a' || ch > 'z') && ch != ' '  && raise(ArgumentError.new('Not a valid character'))
    end

  end

end
