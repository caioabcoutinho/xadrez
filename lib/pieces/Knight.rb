# /xadrez/lib/pieces/Knight.rb
require_relative 'stepable' # Importa o novo módulo

class Knight < Piece
  include Stepable # Inclui o comportamento de "dar um passo"

  def symbol
    symbol_char = @color == :white ? "♘" : "♞"
    # Corrigindo a cor para o time preto ser amarelo
    text_color = @color == :white ? :light_white : :light_white
    symbol_char.colorize(text_color)
  end

  # O método `moves` agora é herdado diretamente do módulo `Stepable`.

  private

  # Este método é exigido pelo módulo Stepable.
  # Ele define os 8 possíveis movimentos em "L" do Cavalo.
  def move_diffs
    [
      [2, 1], [2, -1],   # Para baixo e para os lados
      [-2, 1], [-2, -1],  # Para cima e para os lados
      [1, 2], [1, -2],   # Para a direita e para cima/baixo
      [-1, 2], [-1, -2]  # Para a esquerda e para cima/baixo
    ]
  end
end