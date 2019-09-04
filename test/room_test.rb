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
      any_date = '2019-02-03'
      next_date = '2019-02-04'
      expect(Hotel::Room.available_room(@rooms, any_date, next_date)).must_equal @rooms.first
    end
    
  end

  describe "add_reservation" do
    before do
      @new_room = Hotel::Room.new(1)
    end

    it "creates and adds the reservation" do
      start_date = '2019-02-03'
      end_date = '2019-02-04'

      expect(@new_room.reservations).must_be_empty

      reservation = @new_room.add_reservation(start_date, end_date)
      
      expect(reservation).must_be_kind_of Hotel::Reservation
      expect(reservation.room_num).must_equal 1
      expect(@new_room.reservations).must_include reservation
      expect(@new_room.reservations.length).must_equal 1
    end
  end
end

