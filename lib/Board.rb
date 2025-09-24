class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def move_piece(start_pos, end_pos, color)
    # Validações gerais
    raise 'A posição final não pode ser a mesma que a inicial' if start_pos == end_pos
    
    piece = self[start_pos]
    raise 'Não há peça na posição inicial' if piece.nil?
    raise 'Essa peça não é sua' if piece.color != color
    
    # --- VALIDAÇÃO DE MOVIMENTO ATUALIZADA ---
    # Agora verifica a lista de 'valid_moves', que impede movimentos que te coloquem em xeque.
    raise 'Movimento ilegal para esta peça' unless piece.valid_moves.include?(end_pos)
    
    # Execução do movimento
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    piece.pos = end_pos
    piece.has_moved = true
  end

  def valid_pos?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def empty?(pos)
    self[pos].nil?
  end

  def populate_board_for_new_game
    back_row_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    (0..7).each do |col|
      self[[1, col]] = Pawn.new(:black, self, [1, col])
      self[[0, col]] = back_row_pieces[col].new(:black, self, [0, col])
    end
    (0..7).each do |col|
      self[[6, col]] = Pawn.new(:white, self, [6, col])
      self[[7, col]] = back_row_pieces[col].new(:white, self, [7, col])
    end
  end

  # [cite_start]Verifica se um rei de uma determinada cor está sob ataque. [cite: 228]
  def in_check?(color)
    king = find_king(color)
    return false if king.nil?
    king_pos = king.pos

    (0..7).each do |row|
      (0..7).each do |col|
        piece = self[[row, col]]
        next if piece.nil? || piece.color == color

        # [cite_start]Verifica se alguma peça inimiga pode se mover (capturar) para a casa do rei. [cite: 231]
        return true if piece.moves.include?(king_pos)
      end
    end
    
    false
  end

  # [cite_start]Verifica se um jogador está em xeque-mate. [cite: 242]
  def checkmate?(color)
    # [cite_start]1. Não é xeque-mate se o jogador não estiver em xeque. [cite: 243]
    return false unless in_check?(color)

    # 2. Itere por todas as peças do jogador em xeque.
    (0..7).each do |row|
      (0..7).each do |col|
        piece = self[[row, col]]
        next if piece.nil? || piece.color != color

        # [cite_start]3. Se QUALQUER peça tiver pelo menos um movimento válido, não é xeque-mate. [cite: 245]
        return false unless piece.valid_moves.empty?
      end
    end

    # [cite_start]Se o loop terminar e nenhuma peça tiver movimentos válidos, é xeque-mate. [cite: 246]
    true
  end
  
  def dup
    new_board = Board.new
    (0..7).each do |row|
      (0..7).each do |col|
        pos = [row, col]
        piece = self[pos]
        new_board[pos] = piece.nil? ? nil : piece.class.new(piece.color, new_board, pos)
      end
    end
    new_board
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = nil
    piece.pos = end_pos unless piece.nil?
  end

  def find_king(color)
    (0..7).each do |row|
      (0..7).each do |col|
        pos = [row, col]
        piece = self[pos]
        return piece if !piece.nil? && piece.is_a?(King) && piece.color == color
      end
    end
    nil
  end
end