# Uso de Unicode e Cores:

# Para uma representação visual mais rica, usaremos caracteres Unicode para as peças de xadrez
# (por exemplo, '♜' para a Torre e '♞' para o Cavalo).
# Para tornar o tabuleiro mais legível e esteticamente agradável,
# usaremos uma gem como a colorize para adicionar cores de fundo às casas,
# alternando entre duas cores para simular um tabuleiro de xadrez real.
# Embora seja possível fazer isso com sequências de escape ANSI brutas,
# uma gem simplifica muito o processo. O resultado será uma string formatada que imprimiremos no console a cada turno.

# O design que estamos construindo demonstra um princípio poderoso da POO: a abstração.
# A classe Board não precisa conhecer as regras específicas de como uma Rook ou um Knight se movem.
# Ela só precisa saber que está lidando com objetos do tipo Piece que respondem a um método #moves.
# Essa separação de responsabilidades, ou desacoplamento, é um objetivo fundamental de um bom design orientado a objetos.
# Uma abordagem ingênua poderia colocar toda a lógica de movimento dentro de um grande case na classe Board, tornando-a frágil e difícil de manter.
# Ao delegar a responsabilidade do movimento para as próprias peças, criamos um sistema flexível.
# Se quiséssemos adicionar uma nova peça exótica, como um "Chanceler",
# precisaríamos apenas criar uma nova classe Chancellor < Piece e implementar seu método #moves, sem alterar a classe Board.
# Isso ilustra como a abstração e o polimorfismo levam a um software mais extensível e de fácil manutenção.