require_relative 'room'
require_relative 'reservation'

module Hotel
  class Front_Desk
    def initialize
      @rooms = Room.create_all
    end

    def reserve_a_block(required_rooms, start_date, end_date)
      if required_rooms > 5
        raise ArgumentError.new("A block can contain a maximum of 5 rooms")
      end

      rooms = @rooms
      available_rooms_by_date = Room.available_rooms_by_date(rooms, start_date, end_date)
      
      if available_rooms_by_date.length >= required_rooms
        room = 0
        while room < required_rooms
          available_rooms_by_date[0].add_reservation(@start_date, @end_date)
          room += 1
        end
      else
        raise StandardError.new("We don't have available rooms to reserve on that days")
      end
    end
  end
end