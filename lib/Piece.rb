class Piece
  attr_reader :color, :board
  attr_accessor :pos, :has_moved

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @has_moved = false
  end

  def moves
    # Implementado por cada subclasse (Pawn, Rook, etc.)
    raise NotImplementedError
  end

  # Filtra a lista de movimentos, removendo qualquer um que coloque o próprio rei em xeque.
  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  def symbol
    # Implementado por cada subclasse
    raise NotImplementedError
  end

  private

  # [cite_start]Simula um movimento em um tabuleiro duplicado para ver se ele resulta em xeque. [cite: 237, 239, 240]
  def move_into_check?(end_pos)
    # Cria uma cópia exata do tabuleiro em memória
    board_dup = @board.dup
    # Executa o movimento na cópia, sem as validações do método principal
    board_dup.move_piece!(@pos, end_pos)
    # Verifica se, nesse novo estado, o rei da nossa cor está em xeque
    board_dup.in_check?(self.color)
  end
end