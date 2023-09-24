# 2023.2-Grupo01-StardewValley

Repositório do trabalho do grupo 01 da disciplina de Sistema de Banco de Dados 1 - FGA UnB

## Alunos

| Matrícula  | Aluno                                                              |
| ---------- | ------------------------------------------------------------------ |
| 22/2014984 | [Edilberto Cantuaria](https://github.com/edilbertocantuaria)       |
| 21/1043683 | [Marcus Vinícius Paiva Martins](https://github.com/marcusmartinss) |
| 15/0154348 | [Matheus Phillipo Silverio Silva](https://github.com/MattSilverio) |
| 21/2002907 | [Zenilda Pedrosa Vieira](https://github.com/ZenildaVieira)         |


## Considerações feitas na modelagem de entidades e relacionamentos e na criação do modelo relacional

* Há mundos diferentes que podem ser escolhidos no início do jogo, após o jogador se identificar com seu nome. Cada um contém uma fazenda diferente para o jogador administrar.
* Cada mundo é formado por regiões ao ar livre que podem conter ou não locais fechados (casas de NPCs, casas de jogadores, lojas e cavernas).
* O jogo é dividido em 4 estações, primavera, verão, outono e inverno, com duração de 28 dias cada. Cada estação controla quais sementes podem florescer ou não e apresentam missões diferentes.
* O jogo começa no dia 1 da primavera. A saúde e a energia do jogador iniciam em 100%. 
* A energia do jogador vai diminuindo ao longo do dia, conforme ele vai executando a missão. Para recuperar sua energia, o jogador pode utilizar a cabana que ele possui para dormir (recuperação de 100%) ou ele pode usar um item consumível que tenha efeito positivo (% depende do item). 
* Já a saúde só diminui se ele combater monstros ou usar itens consumíveis que causam efeito negativo. Há também itens consumíveis que podem aumentar o nível da saúde.
* O jogador possui habilidades de coleta, cultivo, mineração, pesca e combate. Os itens obtidos com essas habilidades podem ser vendidos e convertidos em ouro. 
* O jogador possui um inventário no qual ficam armazenados todos os itens que ele possui com suas respectivas quantidades.
* O jogador pode estar em uma região ao ar livre ou pode estar em um dos locais fechados que ele contém. 
* O jogador pode entrar nas cavernas para obter itens através de sua habilidade de mineração. Essas cavernas podem conter monstros que o jogador precisa combater para sobreviver.
* Nesse combate, os monstros podem provocar algum dano a saúde do jogador ou vice-versa, dependendo do nível de combate que o jogador alcançou e o nível de defesa do monstro e, também, do dano que a arma do jogador ou que o monstro podem causar.
* Os monstros que forem mortos (ou seja, quando a saude daquela instância chegar a zero) dropam itens específicos para o jogador.
* Todos NPCs (personagens não jogáveis) também possuem uma cabana e podem ser ou não proprietários de uma ou mais lojas. Cada um possui uma profissão e podem dialogar com o jogador, dando dicas sobre como jogar. Os donos de lojas podem vender itens para o jogador.
* O jogo possui diversos tipos de itens, a saber: ferramentas, sementes, armas, consumíveis, vestimentas e produtos de artesanato (crafting).
* As ferramentas tem finalidade própria, como por exemplo, um machado para cortar um árvore ou uma espada para combater um monstro.
* Assim como as vestimentnas, os itens consumíveis podem causar efeitos positivos ou negativos nos níveis de energia, saúde e nível de combate do jogador (defesa).
* As armas também possuem finalidade específica, além de um valor de dano.
* O jogador, por fim, pode criar itens manufaturados, chamados de artesanato, através de receitas disponíveis e usá-los na sua fazenda.




## Histórico de versões

| Versão |    Data    | Descrição                 | Autor                                              | Revisão |
| :----: | :--------: | ------------------------- | -------------------------------------------------- | ------- |
| `1.0`  | 24/09/2023 | Inclusão das considerações feitas na modelagem | [Zenilda Vieira](https://github.com/ZenildaVieira) |         |