require_relative "test_helper"

describe "Reservation" do
  describe "#initialize" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @reservation = Hotel::Reservation.new(1, @start_date, @end_date)
    end

    it "create an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end
end