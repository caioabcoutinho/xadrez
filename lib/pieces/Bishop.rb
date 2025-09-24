class Bishop < Piece

    def moves()
    end
    
    def symbol
        @color == :white ? "♝" : "♗"
    end
end