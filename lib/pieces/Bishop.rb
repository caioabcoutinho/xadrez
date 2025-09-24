# /xadrez/lib/pieces/Bishop.rb
require_relative 'slideable' # Importa o nosso novo módulo

class Bishop < Piece
  include Slideable # "Mistura" a lógica do módulo na classe Bispo

  def symbol
    symbol_char = @color == :white ? "♗" : "♝"
    # Corrigindo a cor para o time preto ser amarelo, como nas outras peças
    text_color = @color == :white ? :light_white : :light_white
    symbol_char.colorize(text_color)
  end

  # O método `moves` agora é herdado diretamente do módulo `Slideable`.
  # Não precisamos escrevê-lo aqui.

  private

  # Este método é exigido pelo módulo Slideable.
  # Ele diz ao módulo quais direções o Bispo pode usar.
  def move_dirs
    DIAGONAL_DIRS
  end
end