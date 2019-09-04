require_relative 'reservation'

module Hotel
  class Room
    attr_reader :room_num, :reservations
    def initialize(room_num, reservations: nil)
      @room_num = room_num
      @reservations = reservations || []
    end

    # Creates and returns an array of all the rooms of the hotel  
    def self.create_all
      rooms = []
      room_num = 1
      until room_num == 21
        new_room = Room.new(room_num)
        rooms << new_room
        room_num += 1
      end
      return rooms
    end

    # Returns the first room available
        
    def self.available_room(rooms, start_date, end_date)
      return rooms.first
    end

    def add_reservation(start_date, end_date)
      reservation = Reservation.new(0, 1, start_date, end_date)
      @reservations << reservation
      return reservation

    end
  end
end