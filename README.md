# checkers

Para a compilação e execução do projeto deve-se seguir os passos descritos abaixo:

Preparação do Ambiente: Baixar ghci, stack e a biblioteca Gloss - junto de suas dependências. Além disso, clonar o repositório em um diretório livre para compilação.

Compilação: Dentro do diretório raiz do projeto, abra o terminal e digite stack build.

Execução: Dentro do diretório raiz, após ter compilado o projeto, digite no terminal stack run.


Como jogar:

O primeiro a jogar são as peças vermelhas.

Com o mouse, selecione uma peça. A peça selecionada ficará verde como indicação de seleção.

Escolha para onde quer que sua peça vá. Caso seja um movimento válido, a peça mudará para o local.

Caso seja um movimento válido de “comer” do oponente, a peça do oponente deixará o tabuleiro.

Quando você comer uma peça e existir uma peça possível de ser comida pela mesma peça jogada, você poderá realizar outro movimento de comer peça do oponente. Isso se segue até não haver mais possíveis peças a serem devoradas.

Após o final da sua jogada, encerra seu turno e é a vez das peças azuis fazerem sua jogada, seguindo as mesmas regras das vermelhas.

O jogo acaba quando todas as peças do oponente forem devoradas ou caso seja impossível continuar o jogo. Nesse último caso, é um empate.
