class Piece
    attr_reader :color, :board
    attr_accessor :position

    def initialize(color, board, pos)
        @color = color
        @board  = board
        @pos = pos
    end

    def moves()
    end

end

