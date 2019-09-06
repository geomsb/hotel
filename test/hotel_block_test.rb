require_relative "test_helper"

describe "Hotel_block" do
  describe "#initialize" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @rooms = Hotel::Room.create_all
      @rate = 180
      @hotel_block = Hotel::Hotel_block.new(@rooms, @start_date, @end_date, @rate)
    end
    it "is an instance of Hotel_block" do
      expect(@hotel_block).must_be_kind_of Hotel::Hotel_block
    end
  end
end