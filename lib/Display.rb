# /xadrez/lib/Display.rb
require 'colorize'

class Display
  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end

  def render
    system('clear') || system('cls')
    puts "Use WASD para se mover. Enter/Espaço para selecionar."
    # LINHA ALTERADA: Adicionamos mais espaços para alinhar com as casas de 3 caracteres
    puts "   a  b  c  d  e  f  g  h"
    @board.grid.each_with_index do |row, i|
      print "#{8 - i} "
      row.each_with_index do |piece, j|
        bg_color = determine_bg_color([i, j])
        # A lógica da peça agora virá do próprio objeto da peça
        symbol = piece.nil? ? "   " : " #{piece.symbol} " # Adicionamos espaços em volta do símbolo

        print symbol.colorize(background: bg_color)
      end
      puts " #{8 - i}"
    end
    # LINHA ALTERADA: Adicionamos mais espaços aqui também
    puts "   a  b  c  d  e  f  g  h"
  end

  private

  def determine_bg_color(pos)
    if @cursor.cursor_pos == pos
      @cursor.selected ? :light_green : :light_yellow
    elsif (pos[0] + pos[1]).even?
      :light_blue # Casa clara
    else
      :dark_blue # Casa escura (mudei para um azul mais escuro para melhor contraste)
    end
  end
end