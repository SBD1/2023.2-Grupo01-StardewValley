# Cronograma

#### Reunião de entrega - Segunda 13/11, 18h30

| Data de Entrega | Tarefa | Responsáveis | Na reunião |
| --- | --- | --- | --- |
| 13/11 - segunda - 18h30 | Transformar pontos desse documento em histórias de usuário | Edilberto e Marcus | Priorização e divisão das histórias de usuários para cada um fazer as store procedures e triggers e define como vão ser feitas as views (e quem vai fazer) |
| 13/11 - segunda - 18h30 | Adaptar e popular o banco de acordo com esse documento e a wiki (o mínimo possível) | Matheus e Zenilda |   |

**Reunião de acompanhamento de status - Quinta 16/11, 15h.**

#### Reunião de entrega - Segunda 20/11, 18h30

| Data de Entrega | Tarefa | Responsáveis | Na reunião |
| --- | --- | --- | --- |
| 20/11 - segunda - 18h30 | Trazer as store procedures, triggers e views prontos | Edilberto, Marcus, Matheus, Zenilda | Definição como serão os testes e como corrigir o que for preciso   |

**Reunião de feedback e verificação de status - Quinta 23/11, 15h.**

#### Gravação: sexta 24/11 - hora a combinar

# Definições iniciais da dinâmica do Jogo

## Primeira tela

* Pede para o jogador fornecer seu nome
* Mostra mundos disponíveis com sua descrição (2 no começo) e pede para jogador escolher um (tabela **Mundo**)
  * _Mundo1: vale + fazenda1 (ênfase coletar, plantar, colher)_
  * _Mundo2: vale + fazenda2 (ênfase combater e minerar)_
* Mostra regiões do mundo escolhido e pede para o jogador escolher uma (tabela **Região join Mundo**)
  * _Cada mundo terá regiões distintas de acordo com a temática do mundo ao qual ele pertence._
* Cria nova linha na tabela **Jogador** com INSERT no nome (os outros campos setam default automaticamente)
* Cria nova linha na tabela **Habilidade** com o INSERT do id-jogador (os outros campos setam default automaticamente)
* Cria linhas na tabela **Item-Inventário** com o id-jogador e id-item (um item de cada daqueles que o jogador já começa com eles)
  * _Itens que o jogador já começa com eles: enxada, picareta, machado, vara de pesca, foice, espada (tabela **Ferramenta** e **Arma** com filtro booleano "começa_jogo_com")_
* Lista na tela o status do Jogador: energia, qtdd-ouro, niveis de habilidade (tabela **Jogador join Habilidade**)
* Lista itens do inventário (tabela **Item-Inventario**)
* Pede confirmação para ir para a nova região (vai para segunda tela)

## Em qualquer tela

* Cada dia começa às 06:00.
* A cada 1 segundo a hora é incrementada em 1 minuto (tabela **Jogador**). Cada dia dura no máximo 18 a 20 minutos efetivos, até o jogador escolher ir dormir.
  * Se a hora = 24:00, reinicia para hora = 00:00.
  * Se a hora = 00:00 avisa que o jogador tem que ir dormir (tabela **Jogador**).
  * Se a energia do jogador atinge 10%, dá a opção de ele ir dormir ou comer algum item consumivel que aumenta a energia (tabela **Consumivel join Efeito**)
  * Dinâmica de dormir (recuperar energia, reiniciar o dia, verificar sementes que já podem ser colhidas):
    * Dá a opção do jogador ir para sua cabana ou continuar jogando
      * Se ele escolher continuar jogando repete essa dinâmica quando for energia = 5% ou hora = 02:00.
      * Se ele não for dormir na segunda oportunidade, inicializa o dia automaticamente com energia = 50% (e avisa que houve penalização) (tabela **Jogador**). Mostra novo status do jogo.
    * Incrementa +1 no dia (tabela **Jogador**)
    * Verifica se dia = 29, se sim volta dia para 01 e incrementa para a próxima estação (tabela **Jogador** e **Estacao**).
    * Verifica se a id-estação não consta na tabela **Estacao** se não constar volta pra primeira id-estacao = 1 (tabela **Jogador**).
    * Se a estação foi alterada, apaga todas as linhas da tabela **Plantacao**.
    * Verifica se na tabela **Plantacao** tem alguma que já pode ser colhida (Plantacao.dia_coleta = jogador.dia), se sim, incrementa inventário, mostra na tela para o jogador saber do incremento e deleta linha da tabela **Plantacao**.
    * Seta energia para 100% novamente (tabela **Jogador**).
  * Dinâmica de comer item com efeito:
    * Mostra os itens consumíveis disponíveis com seus efeitos e pede pra o jogador escolher
    * Incremetna ou decrementa a energia do jogador

## Segunda Tela - Tela de regiao

* Mostra na tela status do jogo: região, estação, dia e hora (tabela **Jogador**)
* Mostra na tela status do Jogador: energia, qtdd-ouro, niveis de habilidade (tabela **Jogador join Habilidade**)
* Mostra na tela a descrição da região atual e os locais fechados que le tem (tabela **Regiao join Local_Fechado join Jogador** e **local_Fechado join _tabela específica de acordo com o local fechado disponível_**)
* Pergunta ao jogador o que ele quer fazer:

1. Coletar
    * Mostra itens que podem ser coletados nessa região, como madeira, feno, pedra, frutos, sementes (tabela **Consumivel** filtrado por região) e pede pra escolher e dispara "dinâmica de coleta."
    * Dinâmica de coleta:
      * Para simplificar, escolhe automaticamente a ferramenta: machado, foice, picareta, de acordo com o item escolhido e informa ao jogador que ele vai usar essa ferramenta (para simplificar na tabela **Item-Ferramenta** vai dizer para qual item ela é usada). Para frutos e sementes não precisa de ferramentas (NULL).
      * Coletar: incrementa no inventário o item colhido e incrementa +1 em habilidade de coleta.
      * Volta para o menu inicial

2. Plantar
    * Mostra sementes disponíveis no inventário e pede pra ele escolher e dispara "dinâmica de plantação".
    * Dinâmica de plantação:
      * Para simplificar já escolhe automaticamente a ferramenta enxada (tabela **Item-Ferramenta** vai dizer para qual item ela é usada) e informa ao jogador que ele vai usar essa ferramenta e realizar a plantação.
      * Após plantar, insere na tabela **Plantacao** o dia que ela vai ser colhida (soma o dia de hoje com o dias-para-crescer da tabela **Informacao_Semente**) e incrementa +1 em habilidade de cultivo.
      * Volta para o menu inicial

3. Pescar (só se tiver na região “praia”)
    * Mostra os itens que podem ser pescados e pede pra escolher (tabela **Consumivel** filtrado por região).
    * Para simplificar já escolhe automaticamente a ferramenta vara de pescar (tabela **Item-Ferramenta** vai dizer para qual item ela é usada) e informa ao jogador que ele vai usar essa ferramenta e realiza a pesca.
    * Após pescar, insere na tabela **Item_Inventario** o item pescado e incrementa +1 em habilidade de pesca.
      * Volta para o menu inicial
  
4. Craftar
    * Mostra receitas disponíveis (tabela **Artesanato** join **Item_Reeita** join **Item_Inventario**) e pedir pra escolher e dispara "dinâmica de crafting"
    * Dinâmica de crafting:
      * Verificar se tem itens suficientes no inventario para a receita escollhida (qtdd na tabela **Item_Inventario**)
      * Se não tiver, avisa e pede pra escolher outro.
      * Se sim, deleta do inventario a quantidade de linhas de itens usados e incrementa no inventario o item craftado.
      * Volta para o menu inicial

5. Conversar com um NPC que consta nesta região (mostra opções)
    * Mostra os NPCs que estão disponíveis e pede pra escolher
    * Mostra fala do NPC tabela **Dialogo**
      * Volta para o menu inicial

6. Minerar ou combater (só se tiver caverna nessa região)
    * Mostra as cavernas que estão disponíveis e pede pra escolher
    * Atualiza local_fechado na tabela **Jogador**
    * Vai para a tela de local fechado "caverna"

7. Ir a um local fechado que consta nesta região (mostra opções)
    * Mostra os locais fechados que estão disponíveis e pede pra escolher
    * Atualiza local_fechado na tabela **Jogador**
    * Vai para a tela de local fechado escolhido

8. Mudar de região (mostra opções)
    * Mostra as regiões que estão disponíveis e pede pra escolher
    * Atualiza regiao  na tabela **Jogador**
    * Reinicia essa tela com a nova região escolhida

9. Ver itens do inventário
    * Mostra os itens do inventário que estão disponíveis
    * Volta para o menu inicial

## Tela de um local fechado

* Mostra na tela status do jogo: região, estação, dia e hora (tabela **Jogador**)
* Mostra na tela status do Jogador: energia, qtdd-ouro, niveis de habilidade (tabela **Jogador join Habilidade**)
* Mostra na tela a descrição da região atual e do local fechado que o jogador está (tabela **Regiao join Local_Fechado join Jogador** e **local_Fechado join _tabela específica de acordo com o local fechado atual**)
* Pergunta ao jogador o que ele quer fazer (opções de acordo com o local fechado atual).

* Se for uma loja:
  * Mostra o estoque da loja para compras (tabela **Item-Estoque-Loja** join **Tipo_Item** e **Tipo_Item** join **_tabela específica de acordo com o tipo de item_**) e pede para ele escolher e dizer a quantidade e dispara "dinâmica de compra".
  * Dinâmica de compra:
    * Verifica se ele tem qtdd_ouro suficiente (preco * quantidade)
    * Se não, informa qtdd_ouro disponível e pede pra escolher outro ou quantidade menor
    * Se sim, decrementa qtdd_ouro, decrementa qtdd do estoque e incrementa inventario com qtdd do item comprado
    * Pergunta se quer comprar novamente (repete processo) ou sair da loja (volta para tela de regiao - segunda tela)

* Se for uma caverna:
  * Pergunta se quer minerar, combater ou sair da caverna.
  * Se quer sair da caverna:
    * Mostra as regiões que estão disponíveis e pede pra escolher
    * Atualiza regiao  na tabela **Jogador**
    * Vai para segunda tela com a nova região escolhida
  * Se quer minerar:
    * Mostra itens que podem ser minerados: pedra, minério de cobre (tabela **Consumivel** filtrado por local_fechado).
    * Para simplificar já escolhe automaticamente a ferramenta picareta (tabela **Item-Ferramenta** vai dizer para qual item ela é usada) e informa ao jogador que ele vai usar essa ferramenta e realiza a mineração.
    * Após minerar, insere na tabela **Item_Inventario** o item minerado e incrementa +1 em habilidade de mineração.
    * Reinicializa tela atual
  * Se quer combater:
    * Mostra instâncias de monstros que podem ser combatidos (tabela **Instancia_Monstro** filtrado por id_caverna).
    * Para simplificar já escolhe automaticamente a arma espada e informa ao jogador que ele vai usar essa arma e realiza o combate (dispara "dinâmica de combate")
      * Dinâmica de combate:
        * verificar características da instancia do monstro (dano, defesa, energia)
        * verificar características do jogador (energia)
        * comparar para combater: jogador.energia e instancia_monstro.energia, mostra a comparação e pergunta se quer golpear e o que mais ????? e defesa??? como funciona???
        * Se sim: ????
        * Se não: ????
        * Se perder: decrementa energia do jogador de acordo com o dano do monstro.
          * Se energia do jogador chegar a 10%, dispara "Dinâmica de comer item com efeito" definida em "Qualquer tela".
        * Se ganhar: decrementa energia da instancia do monstro em 25%. Se a energia do monstro chegar a zero (após 4 golpes), informa que o monstro foi morto, incrementa no inventário o item dropado, incrementa +1 na habilidade combate e deleta a instancia do monstro.
    * Reinicializa tela atual

* Se for uma casa do NPC:
  * Mostra os NPCs que estão disponíveis e pede pra escolher
  * Mostra fala do NPC tabela **Dialogo**
  * Pergunta se quer dialogar novamente (repete processo)
    * Se sim, reinicializa essa tela
    * Se não, mostra as regiões que estão disponíveis e pede pra escolher
      * Atualiza regiao  na tabela **Jogador**
      * Vai para segunda tela com a nova região escolhida

* Se for a casa do jogador:
  * Pergunta se ele quer ir dormir ou não
    * Se sim, dispara a "dinâmica de dormir" (definida em "Qualquer tela")
    * Se não, mostra as regiões que estão disponíveis e pede pra escolher
      * Atualiza regiao  na tabela **Jogador**
      * Vai para segunda tela com a nova região escolhida

# O que pode ficar pra entrega final:

1. Vestimenta
2. Missao
