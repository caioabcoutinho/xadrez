class Board
    attr_reader :board

    def initialize
        @board = Array.new(8) {Array.new(8)}
    end

    # Parece meio doido mas da pra gente chamar board[pos] pra ter o valor da casa
    def [](pos) # Get do acesso às casas com as coordenadas [linha, coluna]
        row, col = pos
        @board[row][col]
    end

    # Parece meio doido também mas da pra gente chamar board[pos] = value pra alterar o valor da casa
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

