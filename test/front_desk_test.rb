require_relative "test_helper"

describe "Front_desk" do
  describe "reserve_and_create_a_block" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @front_desk = Hotel::Front_Desk.new
      @rooms_block = [@front_desk[0], @front_desk[1], @front_desk[2]]
    end

    it "checks if all the rooms are available for that specific range and it reserves and creates the block." do
      new_block = @front_desk.reserve_a_block(@rooms_block, @start_date, @end_date)
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
