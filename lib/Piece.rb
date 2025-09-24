class Piece
  attr_reader :color, :board
  attr_accessor :pos, :has_moved

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @has_moved = false # [cite: 259] Adicionado para rastrear o estado do primeiro movimento.
  end

  def moves
    # Este método DEVE ser implementado por cada subclasse.
    # Ele retorna um array de movimentos teoricamente possíveis.
    raise NotImplementedError
  end

  def valid_moves
    # Filtra a lista de movimentos, removendo qualquer um que coloque o rei em xeque.
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  def symbol
    # Cada subclasse deve definir seu próprio símbolo.
    raise NotImplementedError
  end

  private

  # Simula um movimento em um tabuleiro duplicado para ver se ele resulta em xeque[cite: 237, 239, 240].
  def move_into_check?(end_pos)
    board_dup = @board.dup
    board_dup.move_piece!(@pos, end_pos)
    board_dup.in_check?(self.color)
  end
end