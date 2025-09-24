# /xadrez/lib/Game.rb

require_relative 'board'
require_relative 'cursor'
require_relative 'display'
require_relative 'HumanPlayer'
require_relative 'piece'
Dir[File.join(__dir__, 'pieces', '*.rb')].each { |file| require file }

class Game
  attr_reader :board, :display, :current_player

  def initialize
    @board = Board.new
    @cursor = Cursor.new([6, 3], @board)
    @display = Display.new(@board, @cursor)
    @player1 = HumanPlayer.new(:white)
    @player2 = HumanPlayer.new(:black)
    @current_player = @player1
    @board.populate_board_for_new_game
  end

  def play
    play_turn until game_over?
    display_results
  end

  private

  def play_turn
    start_pos = nil
    end_pos = nil

    until start_pos && end_pos
      display.render
      puts "É a vez do jogador #{current_player.color}."
      # [cite_start]Notifica o jogador se ele estiver em xeque. [cite: 189]
      puts "XEQUE!" if board.in_check?(current_player.color)

      input = @cursor.get_input

      if input
        if start_pos.nil?
          start_pos = input
          if board[start_pos].nil? || board[start_pos].color != current_player.color
            puts "Casa vazia ou peça do oponente. Selecione uma peça sua."
            sleep(1.5)
            start_pos = nil
            @cursor.selected = false
          end
        else
          end_pos = input
        end
      end
    end

    board.move_piece(start_pos, end_pos, current_player.color)
    switch_players!
    
  rescue StandardError => e
    puts "Erro: #{e.message}. Tente novamente."
    sleep(2)
    # Reseta a seleção do cursor em caso de movimento inválido
    @cursor.selected = false
    retry
  end

  def switch_players!
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  # O jogo termina se algum jogador estiver em xeque-mate.
  def game_over?
    board.checkmate?(:white) || board.checkmate?(:black)
  end

  def display_results
    display.render
    if board.checkmate?(:white)
      puts "Xeque-mate! O jogador que está jogando com as Pretas venceu!"
    elsif board.checkmate?(:black)
      puts "Xeque-mate! O jogador que está jogando com as Brancas venceu!"
    end
  end
end