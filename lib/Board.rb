class Board
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @board[row][col] = value
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise 'Não há peça na posição inicial' if piece.nil?

    self[end_pos] = piece
    self[start_pos] = nil
    piece.pos = end_pos
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
      self[[1, col]] = Pawn.new(:white, self, [1, col])
      self[[0, col]] = back_row_pieces[col].new(:white, self, [0, col])
    end

    (0..7).each do |col|
      self[[6, col]] = Pawn.new(:black, self, [6, col])
      self[[7, col]] = back_row_pieces[col].new(:black, self, [7, col])
    end
  end
end