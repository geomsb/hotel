module Hotel
  class Room
    attr_reader :room_num, :reservations
    def initialize(room_num:, reservations: nil)
      @room_num = room_num
      @reservations = reservations || []
    end
  end
end