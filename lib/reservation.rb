module Hotel
  class Reservation
    attr_reader :room_num, :start_date, :end_date

    def initialize(room_num, start_date, end_date)
      @room_num = room_num
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      
    end

    def cost
      return (@end_date - @start_date) * 200
    end
    
  end
end