module Hotel
  class Hotel_block
    attr_reader :rooms, :start_date, :end_date, :rate

    def initialize(rooms, start_date, end_date, rate)
      @rooms = rooms
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @rate = rate
    end
  end
end
