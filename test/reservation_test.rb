require_relative "test_helper"

describe "Reservation" do
  describe "#initialize" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @reservation = Hotel::Reservation.new(1, @start_date, @end_date)
    end

    it "creates an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "#cost" do
    before do
      @start_date = '2019-02-03'
      @end_date = '2019-02-04'
      @reservation = Hotel::Reservation.new(1, @start_date, @end_date)
      @second_reservation = Hotel::Reservation.new(2, '2019-02-03', '2019-02-05')
    end

    it "gives the cost of a reservation" do
      expect(@reservation.cost).must_equal 200
      expect(@second_reservation.cost).must_equal 400
    end
  end
end