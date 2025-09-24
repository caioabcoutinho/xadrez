# /xadrez/lib/pieces/Rook.rb
require_relative 'slideable' # Importa o módulo de movimento

class Rook < Piece
  include Slideable # Inclui o comportamento de "deslizar"

  def symbol
    symbol_char = @color == :white ? "♖" : "♜"
    # Corrigindo a cor para o time preto ser amarelo
    text_color = @color == :white ? :light_white : :light_white
    symbol_char.colorize(text_color)
  end

  # Não precisamos do método 'moves' aqui, pois ele já vem do módulo.

  private

  # Diz ao módulo 'Slideable' quais direções a Torre usa.
  def move_dirs
    HORIZONTAL_DIRS # Constante definida no módulo Slideable
  end
end