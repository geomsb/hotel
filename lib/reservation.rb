module Hotel
  class Reservation
    attr_reader :id, :room_num, :start_date, :end_date
    def initialize(id, room_num, start_date, end_date)
      @id = id
      @room_num = room_num
      @start_date = start_date
      @end_date = end_date
    end
  end
end