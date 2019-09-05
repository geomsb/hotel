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
      @reservations.each do |reservation|
        unless ((Date.parse(start_date) <= reservation.end_date) && (Date.parse(start_date) >= reservation.start_date)) && ((Date.parse(end_date) >= reservation.end_date) && (Date.parse(end_date) >= reservation.start_date))
          return true
        else
          return false 
        end
      end
    end

    # Returns an array with the available rooms
    def self.available_rooms_by_date(rooms, start_date, end_date)
      available_rooms = []
      rooms.each do |room|
        if room.available_date?(start_date,end_date) == true
        available_rooms << room 
        end
      end
      return available_rooms
    end

    # Returns an array with the reserved rooms
    def self.reserved_rooms_by_date(rooms, start_date, end_date)
      reserved_rooms = []
      rooms.each do |room|
        if room.available_date?(start_date,end_date) == false
          reserved_rooms << room 
        end
      end
      return reserved_rooms
    end


    # Returns the first room available
    def self.available_room(rooms, start_date, end_date)
      return rooms.first
    end

    # Create and add a reservation
    def add_reservation(start_date, end_date)
      if Date.parse(start_date) > Date.parse(end_date)
        raise ArgumentError.new("The start date cannot be greater than the end date")
      end

      reservation = Reservation.new(@room_num, start_date, end_date)
      @reservations << reservation
      return reservation
    end


  end
end