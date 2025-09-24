# /xadrez/lib/cursor.rb
require 'io/console' # Biblioteca para ler caracteres do teclado

class Cursor
  attr_reader :cursor_pos, :board
  attr_accessor :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false # Para rastrear se uma peça foi selecionada
  end

  # Lê um único caractere do teclado
  def get_input
    key = STDIN.getch
    handle_key(key)
  end

  private

  # Mapeia a tecla pressionada para uma ação
  def handle_key(key)
    case key
    when :return, :space, "\r", " " # Teclas para Enter/Espaço
      @selected = !@selected
      return @cursor_pos
    when 'w', 'W', "\e[A" # W ou Seta para Cima
      update_pos([-1, 0])
    when 's', 'S', "\e[B" # S ou Seta para Baixo
      update_pos([1, 0])
    when 'a', 'A', "\e[D" # A ou Seta para Esquerda
      update_pos([0, -1])
    when 'd', 'D', "\e[C" # D ou Seta para Direita
      update_pos([0, 1])
    when "\u0003" # CTRL+C
      exit 0
    end
    nil
  end

  # Atualiza a posição do cursor, garantindo que ele não saia do tabuleiro
  def update_pos(diff)
    new_pos = [@cursor_pos[0] + diff[0], @cursor_pos[1] + diff[1]]
    @cursor_pos = new_pos if board.valid_pos?(new_pos)
  end
end