# /xadrez/lib/pieces/King.rb
require_relative 'stepable' # Importa o módulo de movimento de "passo"

class King < Piece
  include Stepable # Inclui o comportamento do módulo

  def symbol
    symbol_char = @color == :white ? "♔" : "♚"
    # Corrigindo a cor para o time preto ser amarelo
    text_color = @color == :white ? :light_white : :light_white
    symbol_char.colorize(text_color)
  end

  private

  # Este método é exigido pelo módulo Stepable.
  # Ele define os 8 possíveis movimentos de um passo do Rei.
  def move_diffs
    [
      [1, 0],   # Para baixo
      [-1, 0],  # Para cima
      [0, 1],   # Para a direita
      [0, -1],  # Para a esquerda
      [1, 1],   # Diagonal para baixo-direita
      [1, -1],  # Diagonal para baixo-esquerda
      [-1, 1],  # Diagonal para cima-direita
      [-1, -1]  # Diagonal para cima-esquerda
    ]
  end
end