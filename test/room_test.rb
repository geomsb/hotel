require_relative "test_helper"

describe "Room" do
  describe "#initialize" do
    before do
      room = Hotel::Room.new(
        room_num: 1,
      )
    end

    it "is an instance of Room" do
      expect(room).must_be_kind_of Hotel::Room
    end
  end

  describe "Room.all" do
    # before do 
    #   rooms = Hotel::Room.all
    # end

    it "returns an array of all rooms" do
      rooms = Hotel::Room.create_all
      expect(rooms).must_be_kind_of Array
    end

    it "creates an instance for each room" do
      rooms = Hotel::Room.create_all
      expect(rooms.length).must_equal 20
      rooms.each do |r|
        expect(r).must_be_kind_of Hotel::Room
      end
    end
  end

end

