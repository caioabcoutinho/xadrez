# Manter o loop principal do jogo (#play), que continuará até que uma condição de fim de jogo (como xeque-mate) seja alcançada.
# Rastrear o jogador atual (@current_player).
# Alternar os turnos após um movimento bem-sucedido.
# Notificar os jogadores sobre o estado do jogo (por exemplo, "Xeque!").

# Requer os outros arquivos dos quais a classe Game depende.
require_relative 'board'
require_relative 'player'
require_relative 'display'
# Você precisará de um arquivo que carregue todas as peças.
# Ex: require_relative 'pieces' 

class Game
  attr_reader :board, :display, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    
    # Define quem começa jogando
    @current_player = @player1
  end

  def play
    until game_over?
      play_turn
    end

    display.render
    puts "Xeque-mate! O jogador #{current_player.color == :white ? :black : :white} venceu!"
  end

  private

  def play_turn
    begin
      display.render
      puts "É a vez do jogador #{current_player.color}."
      
      # (Lógica de notificação de xeque)
      if board.in_check?(current_player.color)
        puts "Atenção: Você está em xeque!"
      end

      # 1. Pede a jogada ao jogador atual
      move_input = current_player.get_move
      
      # 2. Converte a entrada (ex: "a2,a4") para coordenadas [[6,0], [4,0]]
      # (Esta lógica de conversão pode ficar em outra classe/método)
      start_pos, end_pos = parse_move(move_input)

      # 3. Tenta mover a peça no tabuleiro
      board.move_piece(start_pos, end_pos, current_player.color)

      # 4. Se o movimento foi bem-sucedido, troca o jogador
      switch_players!
    rescue StandardError => e
      # Se um erro ocorrer (ex: movimento inválido), notifica o jogador e permite que ele tente novamente.
      puts "Erro: #{e.message}. Tente novamente."
      retry # O 'retry' faz com que o bloco 'begin' execute novamente.
    end
  end

  def switch_players!
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  # Verifica se o jogo terminou.
  # Por enquanto, só verifica xeque-mate.
  def game_over?
    board.checkmate?(current_player.color)
  end

  # Método auxiliar para converter a notação de xadrez em coordenadas de array.
  # Esta é uma implementação simples para começar.
  def parse_move(input)
    # Lógica de conversão virá aqui
    # Ex: "a2,a4" -> [[6, 0], [4, 0]]
    # Por enquanto, vamos retornar um valor fixo para evitar erros.
    # Você precisará implementar esta conversão.
    raise "Função de parse não implementada!" unless input.match?(/[a-h][1-8],[a-h][1-8]/)
    
    start_str, end_str = input.split(',')
    start_pos = [8 - start_str[1].to_i, start_str[0].ord - 'a'.ord]
    end_pos = [8 - end_str[1].to_i, end_str[0].ord - 'a'.ord]
    
    [start_pos, end_pos]
  end

end
