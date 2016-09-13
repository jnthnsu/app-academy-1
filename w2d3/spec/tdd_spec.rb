require 'rspec'
require 'tdd'

describe Array do
  let(:array){ [1, 2, 1, 3, 3]}
  let(:array2){[-1,0,2,-2,1]}
  let(:array3){[[0,1,2],[3,4,5],[6,7,8]]}

  describe "#my_uniq" do
  it "removes duplicates from an array" do
    expect(array.my_uniq).to eq([1, 2, 3])
  end
end

 describe "#two_sum" do
  it "Finds pair positions" do
    expect(array2.two_sum).to eq([[0,4],[2,3]])
  end
end

describe "#my_transpose" do
  it "transposes an array" do
   expect(array3.my_transpose).to eq([[0,3,6],[1,4,7],[2,5,8]])
  end
end

describe "#stock_prices" do
  it "calculates best buy, sell dates" do
   expect(array2.stock_prices).to eq([0, 2])
  end
end
end

describe Towers do
  subject(:towers){ Towers.new }

  describe "#move" do
    it "moves" do
      towers.move
      expect(towers.towers).to eq([[3,2], [1], []])
    end
  end

  describe "#won?" do
    it "ends" do
      towers.run
      expect(towers.won?).to be_truthy
    end
  end
end
