require_relative 'room'
require_relative 'reservation'

module Hotel
  class Front_Desk
    def initialize
      @rooms = Room.create_all
    end

    # Before reserving a block I need to check if all the rooms are available for that specific range 

    def reserve_a_block(rooms, start_date, end_date)

      if rooms.length > 5
        raise ArgumentError.new("A block can contain a maximum of 5 rooms")
      end

      available_block_rooms = []

      rooms.each do |room|
        if room.available_date?(start_date, end_date) == true
          available_block_rooms += room
        else
          raise StandardError.new("The room #{room.room_num} is not available for that dates")
      end

      if available_block_rooms.length == rooms.length
        available_block_rooms.each do |room|
          room.add_reservation(@start_date, @end_date)
        end
      end
    end
  end
end