# /xadrez/lib/pieces/slideable.rb

# Este módulo entende como se mover em linhas retas (horizontal, vertical, diagonal).
module Slideable
  # Constantes para representar as direções.
  # dx é a mudança na linha (row), dy é a mudança na coluna (col).
  HORIZONTAL_DIRS = [ [0, 1], [0, -1], [1, 0], [-1, 0] ].freeze
  DIAGONAL_DIRS = [ [1, 1], [1, -1], [-1, 1], [-1, -1] ].freeze

  # O método principal que será chamado pela peça.
  def moves
    possible_moves = []
    # A peça que incluir este módulo DEVE implementar o método `move_dirs`.
    move_dirs.each do |dx, dy|
      # Para cada direção, calcula todos os movimentos possíveis até encontrar um bloqueio.
      possible_moves.concat(grow_unblocked_moves_in_dir(dx, dy))
    end
    possible_moves
  end

  private

  # Este método gera movimentos em uma única direção.
  def grow_unblocked_moves_in_dir(dx, dy)
    moves_in_dir = []
    current_pos = @pos.dup # Começa da posição atual da peça

    loop do
      # Move um passo na direção dada
      current_pos = [current_pos[0] + dx, current_pos[1] + dy]

      # Para se a posição sair do tabuleiro
      break unless board.valid_pos?(current_pos)

      if board.empty?(current_pos)
        # Se a casa estiver vazia, é um movimento válido. Continue na mesma direção.
        moves_in_dir << current_pos
      else
        # Se a casa não está vazia, há uma peça.
        target_piece = board[current_pos]
        if target_piece.color != @color
          # Se for uma peça inimiga, é um movimento válido (captura). Pare aqui.
          moves_in_dir << current_pos
        end
        # Se for uma peça amiga ou inimiga, o caminho está bloqueado. Pare aqui.
        break
      end
    end
    
    moves_in_dir
  end
end