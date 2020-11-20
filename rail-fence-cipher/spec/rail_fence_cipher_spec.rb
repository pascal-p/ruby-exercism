require 'spec_helper'


RSpec.describe RailFenceCipher do

  context 'internal functions' do

    before :example do
      @msg = 'messagetoencode'
      @rails = 4
      @rfc = RailFenceCipher.new(@msg, @rails)
    end

    it 'enums the rails' do
      expect(@rfc.send(:enum_rails)).to cover(3)
    end

    it 'fills the rails' do
      ary = @rfc.send(:fill, @msg)
      
      expect(ary.length).to eq(@rails)

      expect(ary[0]).to match_array(["m", ".", ".", ".", ".", ".", "e", ".", ".", ".", ".", ".", "o", ".", "."])
      expect(ary[1]).to match_array([".", "e", ".", ".", ".", "g", ".", "t", ".", ".", ".", "c", ".", "d", "."])
      expect(ary[2]).to match_array([".", ".", "s", ".", "a", ".", ".", ".", "o", ".", "n", ".", ".", ".", "e"])
      expect(ary[3]).to match_array([".", ".", ".", "s", ".", ".", ".", ".", ".", "e", ".", ".", ".", ".", "."])
    end

    it 'calculates the right incr sequence' do
      kx, incr = 0, true

      0.upto(@rails - 2) do |ix|
        kx, incr = @rfc.send(:incr_fn, kx, incr)

        expect(kx).to eq(ix + 1)
        expect(incr).to be
      end

      kx, incr = @rfc.send(:incr_fn, kx, incr)
      expect(kx).to eq(@rails - 2)
      expect(incr).not_to be      
    end

    it 'calculates the right decr sequence' do
      kx, incr = @rails - 2, false

      (@rails - 2).downto(0) do |ix|        
        expect(kx).to eq(ix)
        expect(incr).not_to be

        kx, incr = @rfc.send(:decr_fn, kx, incr)
      end

      expect(kx).to eq(1)
      expect(incr).to be
    end
    
  end

end
