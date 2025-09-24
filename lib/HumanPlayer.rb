# /xadrez/lib/HumanPlayer.rb
class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end
  
  # O método get_move não é mais necessário aqui.
  # A classe agora serve apenas para identificar o jogador.
end