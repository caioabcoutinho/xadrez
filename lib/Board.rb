class Board
    attr_reader :board

    def initialize
        @board = Array.new(8) {Array.new(8)}
        populate_board
    end

    def populate_board
        (0..7).each { |col| self[[1, col]] = Pawn.new(:white, self, [1, col]) }
        self[[0, 0]] = Rook.new(:white, self, [0, 0])
        self[[0, 1]] = Knight.new(:white, self, [0, 1])
        self[[0, 2]] = Bishop.new(:white, self, [0, 2])
        self[[0, 3]] = Queen.new(:white, self, [0, 3])
        self[[0, 4]] = King.new(:white, self, [0, 4])
        self[[0, 5]] = Bishop.new(:white, self, [0, 5])
        self[[0, 6]] = Knight.new(:white, self, [0, 6])
        self[[0, 7]] = Rook.new(:white, self, [0, 7])

        (0..7).each { |col| self[[6, col]] = Pawn.new(:black, self, [6, col]) }
        self[[7, 0]] = Rook.new(:black, self, [7, 0])
        self[[7, 1]] = Knight.new(:black, self, [7, 1])
        self[[7, 2]] = Bishop.new(:black, self, [7, 2])
        self[[7, 3]] = Queen.new(:black, self, [7, 3])
        self[[7, 4]] = King.new(:black, self, [7, 4])
        self[[7, 5]] = Bishop.new(:black, self, [7, 5])
        self[[7, 6]] = Knight.new(:black, self, [7, 6])
        self[[7, 7]] = Rook.new(:black, self, [7, 7])
    end

    def [](pos) # Get do acesso às casas com as coordenadas [linha, coluna]
        row, col = pos
        @board[row][col]
    end

    def []=(pos, value) # Set da modificação das casas com as coordenadas [linha, coluna]
        row, col = pos
        @board[row][col] = value
    end

    def move_piece(start_pos, end_pos) # Move a peça de uma posição inicial para uma final, atualizando o estado do tabuleiro.
        piece = self[start_pos]
        raise 'Não há peça na posição inicial' if piece.nil?

        #TODO adicionar a verificação se o movimento está nos movimentos legais da peça na classe Game
        self[end_pos] = piece
        self[start_pos] = nil
        piece.pos = end_pos # Atualiza a posição da própria peça
    end

    def valid_pos?(pos)
        row, col = pos
        row.between?(0, 7) &&  col.between?(0, 7) # Método pra ver se a posição está entre 0 e 7
    end

    def empty?(pos)
        self[pos].nil?
    end
end

