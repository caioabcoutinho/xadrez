# /xadrez/lib/pieces/Pawn.rb
class Pawn < Piece
  def symbol
    symbol_char = @color == :white ? "♙" : "♟"
    # Corrigindo a cor para o time preto ser amarela, como nas outras peças
    text_color = @color == :white ? :light_white : :light_white
    symbol_char.colorize(text_color)
  end

  # O método principal que retorna todos os movimentos possíveis.
  def moves
    # Concatena os resultados dos métodos auxiliares de movimento.
    forward_steps + side_attacks
  end

  private

  # Determina a direção do movimento com base na cor da peça.
  # Para brancas, a linha diminui (-1). Para pretas, a linha aumenta (+1).
  def forward_dir
    @color == :white ? -1 : 1
  end

  # Verifica se o peão está em sua linha inicial.
  def at_start_row?
    start_row = (@color == :white) ? 6 : 1
    @pos[0] == start_row
  end

  # Calcula os movimentos possíveis para frente (um ou dois passos).
  def forward_steps
    steps = []
    row, col = @pos

    # Movimento de um passo
    one_step = [row + forward_dir, col]
    if board.empty?(one_step)
      steps << one_step

      # Movimento de dois passos (só é possível se o de um passo também for)
      two_steps = [row + 2 * forward_dir, col]
      if at_start_row? && board.empty?(two_steps)
        steps << two_steps
      end
    end
    
    steps
  end

  # Calcula os possíveis movimentos de captura nas diagonais.
  def side_attacks
    attacks = []
    row, col = @pos

    # Posições de ataque possíveis (esquerda e direita na diagonal)
    attack_positions = [
      [row + forward_dir, col - 1],
      [row + forward_dir, col + 1]
    ]

    attack_positions.each do |attack_pos|
      # Ignora se a posição estiver fora do tabuleiro
      next unless board.valid_pos?(attack_pos)

      # Verifica se há uma peça na casa de ataque e se ela é do oponente
      target_piece = board[attack_pos]
      if !target_piece.nil? && target_piece.color != @color
        attacks << attack_pos
      end
    end

    attacks
  end
end