# /xadrez/lib/pieces/Queen.rb
require_relative 'slideable' # Importa o módulo de movimento

class Queen < Piece
  include Slideable # Inclui o comportamento de "deslizar"

  def symbol
    symbol_char = @color == :white ? "♕" : "♛"
    # Corrigindo a cor para o time preto ser amarelo
    text_color = @color == :white ? :light_white : :light_white
    symbol_char.colorize(text_color)
  end

  private

  # Diz ao módulo 'Slideable' quais direções a Rainha usa.
  # A Rainha usa tanto as direções horizontais/verticais QUANTO as diagonais.
  def move_dirs
    HORIZONTAL_DIRS + DIAGONAL_DIRS
  end
end