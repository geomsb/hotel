require_relative "test_helper"

describe "Front_desk" do
  describe "reserve_and_create_a_block" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @front_desk = Hotel::Front_Desk.new
    end

    it "creates the block" do
      @front_desk.create_a_block([1,2,3], @start_date, @end_date, 180)
    end
  end

  describe "reserve_room_block" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @front_desk = Hotel::Front_Desk.new
    end

    it "reserves a block room" do
      @front_desk.create_a_block([1,2,3], @start_date, @end_date, 180)
      expect(@front_desk.reserve_room_block(1, @start_date, @end_date)).must_be_kind_of Hotel::Reservation
    end

    it "raises a StandardError if there are no blocks and you try to reserve" do
      expect do (@front_desk.reserve_room_block(1, @start_date, @end_date))end.must_raise StandardError
    end

    it "raises a StandardError if you try to reserve a room and it is not on-hold for those dates" do
      @front_desk.create_a_block([1,2,3], @start_date, @end_date, 180)
      expect do (@front_desk.reserve_room_block(1, '2019-02-13', '2019-02-14'))end.must_raise StandardError
    end
  end

  describe "available_block_rooms" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @front_desk = Hotel::Front_Desk.new
      @block = @front_desk.create_a_block([1,2,3], @start_date, @end_date, 180)
      @front_desk.reserve_room_block(1, @start_date, @end_date)
    end

    it "returns an array of available rooms" do
      expect(@front_desk.available_block_rooms(@block)).must_be_kind_of Array
      expect(@front_desk.available_block_rooms(@block).length).must_equal 2
    end

  end

  describe "reserve_room" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @front_desk = Hotel::Front_Desk.new
    end

    it "should determine which room to use for the reservation" do
      expect(@front_desk.reserve_room(@start_date, @end_date)).must_be_kind_of Hotel::Reservation
    end

    it "reserves a room" do
      room = Hotel::Room.new(1)
      front_desk = Hotel::Front_Desk.new(rooms: [room])
      reservation = front_desk.reserve_room(@start_date, @end_date)
      expect(room.reservations[0]).must_equal reservation
    end

    it "raises an error if there are not any rooms available" do
      room = Hotel::Room.new(1)
      front_desk = Hotel::Front_Desk.new(rooms: [room])
      front_desk.reserve_room(@start_date, @end_date)
      expect do (front_desk.reserve_room(@start_date, @end_date))end.must_raise StandardError
    end
  end
end
