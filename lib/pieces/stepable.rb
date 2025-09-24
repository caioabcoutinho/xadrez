# /xadrez/lib/pieces/stepable.rb

# Este módulo entende como se mover para um conjunto fixo de posições.
module Stepable
  # O método principal que será chamado pela peça.
  def moves
    possible_moves = []
    # A peça que incluir este módulo DEVE implementar o método `move_diffs`.
    move_diffs.each do |dx, dy|
      current_row, current_col = @pos

      # Calcula a nova posição com base na diferença de movimento
      new_pos = [current_row + dx, current_col + dy]

      # Verifica se a nova posição está dentro do tabuleiro
      next unless board.valid_pos?(new_pos)

      # Verifica a peça na posição de destino
      target_piece = board[new_pos]

      if target_piece.nil?
        # Se a casa estiver vazia, é um movimento válido.
        possible_moves << new_pos
      elsif target_piece.color != @color
        # Se houver uma peça inimiga, é um movimento válido (captura).
        possible_moves << new_pos
      end
      # Se houver uma peça amiga, o movimento não é válido e é ignorado.
    end
    possible_moves
  end
end