require_relative "test_helper"

describe "Hotel_block" do
  describe "reserve_and_create_a_block" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @front_desk = Hotel::Front_Desk.new(rooms)
      @rooms_block = [@front_desk[0], @front_desk[1], @front_desk[2]]
    end

    it "checks if all the rooms are available for that specific range and it reserves and creates the block." do
      new_block = @front_desk.reserve_a_block(@rooms_block, @start_date, @end_date)
    end

  end
end
