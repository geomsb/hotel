require_relative "test_helper"

describe 'Room' do
  describe '#initialize' do
    before do
      @room = Hotel::Room.new(
        room_num: 1,
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end
end

