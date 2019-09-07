require_relative 'room'
require_relative 'reservation'

module Hotel
  class Front_Desk

    def initialize(rooms: nil)
      @rooms = rooms || Room.create_all
    end

    def reserve_room(start_date, end_date)
      available_rooms = Room.available_rooms_by_date(@rooms, start_date, end_date)
      return available_rooms[0].add_reservation(start_date, end_date)
    end

    # Before reserving a block I need to check if all the rooms are available for that specific range, then
    # I reserve the rooms and create the block. 

    def reserve_and_create_a_block(rooms_block, start_date, end_date)

      if rooms_block.length > 5
        raise ArgumentError.new("A block can contain a maximum of 5 rooms")
      end

      available_block_rooms = []

      rooms_block.each do |room|
        if room.available_date?(start_date, end_date) == true
          available_block_rooms << room
        else
          raise StandardError.new("The room #{room.room_num} is not available for that dates")
        end
      end

      if available_block_rooms.length == rooms_block.length
        new_block = Hotel::Hotel_block.new(available_block_rooms, start_date, end_date)
        available_block_rooms.each do |room|
          room.add_reservation(start_date, end_date)
        end
      end
    end
  end
end