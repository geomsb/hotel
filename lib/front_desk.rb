require_relative 'room'
require_relative 'reservation'

module Hotel
  class Front_Desk

    def initialize(rooms: nil)
      @rooms = rooms || Room.create_all
      @rooms_by_number = {}

      @rooms.each do |room|
        @rooms_by_number[room.room_num] = room
      end
      @blocks = []
    end

    def reserve_room_block(room_num, start_date, end_date)
      
      if @blocks.length == 0
        raise StandardError.new("There are no blocks created")
      end

      included_in_block = @blocks.any? do |block|
        block.rooms.include?(@rooms_by_number[room_num]) && (block.start_date == Date.parse(start_date)) && (block.end_date == Date.parse(end_date))
      end

      if included_in_block 
        return @rooms_by_number[room_num].add_reservation(start_date, end_date)
      else
        raise StandardError.new("That room is not on-hold for those dates")
      end
    end

    def reserve_room(start_date, end_date)
      available_rooms = Room.available_rooms_by_date(@rooms, start_date, end_date)
      if available_rooms.length == 0
        raise StandardError.new("There are not any available rooms for that days")
      end

      @blocks.each do |block|
        if block.rooms.include?(available_rooms[0].room_num)
          raise StandardError.new("The room number #{available_rooms[0].room_num} cant be reserved because it is on-hold by a block")
        end
      end

      return available_rooms[0].add_reservation(start_date, end_date)
    end

    # Before reserving a block I need to check if all the rooms are available for that specific range, then
    # I reserve the rooms and create the block. 

    def create_a_block(rooms_block, start_date, end_date, rate)

      if rooms_block.length > 5
        raise ArgumentError.new("A block can contain a maximum of 5 rooms")
      end

      available_block_rooms = []

      rooms_block.each do |room_num|
        room = @rooms_by_number[room_num]
        if room.available_date?(start_date, end_date) == true
          available_block_rooms << room
        else
          raise StandardError.new("The room #{room_num} is not available for that dates")
        end
      end

      if available_block_rooms.length == rooms_block.length
        new_block = Hotel::Hotel_block.new(available_block_rooms, start_date, end_date, rate)
        @blocks << new_block
      end
    end
  end
end