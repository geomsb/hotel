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

  describe "add_reservation" do
    before do
      @new_room = Hotel::Room.new(1)
      @second_room = Hotel::Room.new(2)
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
    end

    it "creates and adds the reservation" do
  
      expect(@new_room.reservations).must_be_empty

      reservation = @new_room.add_reservation(@start_date, @end_date)
      
      expect(reservation).must_be_kind_of Hotel::Reservation
      expect(reservation.room_num).must_equal 1
      expect(@new_room.reservations).must_include reservation
      expect(@new_room.reservations.length).must_equal 1
    end

    it "creates a reservation for a specific room" do
      reservation = @second_room.add_reservation(@start_date, @end_date)
      expect(reservation.room_num).must_equal 2
    end

    it "raises an argument error if the start_date is higher than the end_date" do
      expect do @second_room.add_reservation('2019-02-04','2019-02-03') end.must_raise ArgumentError
    end

    it "raises an argument error if the room is not available" do
      @new_room.add_reservation(@start_date, @end_date)
      expect do @new_room.add_reservation(@start_date, @end_date) end.must_raise StandardError
    end

  end

  describe "available_date" do
    before do
      @new_room = Hotel::Room.new(1)
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
    end

    it "returns true or false if the room is available for a specific date" do
      @new_room.add_reservation(@start_date, @end_date)
      expect(@new_room.available_date?(@start_date, @end_date)).must_equal false
      expect(@new_room.available_date?('2019-02-13', '2019-02-14')).must_equal true
    end

    it "allows reservations to start on the same day that another reservation for the same room ends" do
      @new_room.add_reservation(@start_date, @end_date)
      @new_room.available_date?(@start_date, @end_date)
      @new_room.add_reservation('2019-02-04', '2019-02-06')
      expect(@new_room.available_date?('2019-02-04', '2019-02-06')).must_equal false
    end
  end

  describe "self.available_rooms_by_date" do
    before do 
      @rooms = Hotel::Room.create_all
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      
    end

    it "returns an array with the available rooms for a specific period of time" do
      available_rooms = Hotel::Room.available_rooms_by_date(@rooms, @start_date, @end_date).must_be_kind_of Array
    end

    it "doesn't return the reserved rooms" do
      @rooms[0].add_reservation(@start_date, @end_date)
      available_rooms = Hotel::Room.available_rooms_by_date(@rooms, @start_date, @end_date)
      expect(available_rooms).wont_include(@rooms[0])
    end

  end

  describe "self.reserved_rooms_by_date" do
    before do 
      @rooms = Hotel::Room.create_all
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
    end
    
    it "returns an array with the reserved rooms for a specific period of time" do
      available_rooms = Hotel::Room.reserved_rooms_by_date(@rooms, @start_date, @end_date).must_be_kind_of Array
    end

    it "returns the reserved rooms" do
      @rooms[0].add_reservation(@start_date, @end_date)
      reserved_rooms = Hotel::Room.reserved_rooms_by_date(@rooms, @start_date, @end_date)
      expect(reserved_rooms).must_include(@rooms[0])
    end

  end

end

