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

    # Returns true or false if the room is available for a specific date
    def available_date?(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)

      available_date = true
      @reservations.each do |reservation|
         if (start_date >= reservation.start_date && start_date < reservation.end_date) ||
         (end_date > reservation.start_date && end_date <= reservation.end_date) ||
         (reservation.start_date >= start_date && reservation.start_date < end_date) ||
         (reservation.end_date > start_date && reservation.end_date <= end_date)
          available_date = false
        end
      end
      return available_date
    end

    # Returns an array with the available rooms
    def self.available_rooms_by_date(rooms, start_date, end_date)
      available_rooms = []
      rooms.each do |room|
        if room.available_date?(start_date,end_date) 
        available_rooms << room 
        end
      end
      return available_rooms
    end

    # Returns an array with the reserved rooms
    def self.reserved_rooms_by_date(rooms, start_date, end_date)
      reserved_rooms = []
      rooms.each do |room|
        unless room.available_date?(start_date,end_date) 
          reserved_rooms << room 
        end
      end
      return reserved_rooms
    end
 
    # Creates and adds a reservation
    def add_reservation(start_date, end_date)
      if start_date > end_date
        raise ArgumentError.new("The start date cannot be greater than the end date")
      end
      if available_date?(start_date, end_date) == true
        reservation = Reservation.new(@room_num, start_date, end_date)
        @reservations << reservation
      else
        raise StandardError.new("This room is not available for that dates")
      end
      return reservation
    end
  end
end