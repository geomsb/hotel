module Hotel
  class Reservation
    attr_reader :room_num, :start_date, :end_date
    def initialize(room_num, start_date, end_date)
      @room_num = room_num
      @start_date = start_date
      @end_date = end_date
    end
  end
end