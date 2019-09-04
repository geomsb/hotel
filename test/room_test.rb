require_relative "test_helper"

describe "Room" do
  describe "#initialize" do
    before do
      @room = Hotel::Room.new(
        room_num: 1,
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end

  describe "Room.all" do
    before do 
      @rooms = Hotel::Room.create_all
    end

    it "returns an array of all rooms" do
      expect(@rooms).must_be_kind_of Array
    end

    it "creates an instance for each room" do
      expect(@rooms.length).must_equal 20
      @rooms.each do |r|
        expect(r).must_be_kind_of Hotel::Room
      end
    end
  end

  describe "available_room" do
    before do 
      @rooms = Hotel::Room.create_all
    end

    it "returns the first room available for the dates given" do
      any_day = '2019-02-03'
      next_day = '2019-02-04'
      expect(Hotel::Room.available_room(@rooms, any_day, next_day)).must_equal @rooms.first
    end    
  end

  # describe "add_reservation" do
  #   before do
  #   end
  #   it "adds the reservation" do
  #     expect(room.reservations).wont_include reservation
  #     previous = room.reservations.length

  #     room.add_reservation(reservation)

  #     expect(room.reservations).must_include reservation
  #     expect(room.reservations).must_equal previous + 1
  #   end
  # end
end

