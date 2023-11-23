## Histórico de versões

| Versão |    Data    | Descrição                                           | Autor                                                        |
| :----: | :--------: | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 13/11/2023 | Criação do documento                                | [Edilberto Cantuaria](https://github.com/edilbertocantuaria) |
| `1.1`  | 13/11/2023 | Adição das tabelas de Local Fechado e Qualquer Tela | [Marcus Martins](https://github.com/marcusmartinss)          |

## User Stories (Histórias de usuário adaptado)

Na tabela 1 consta um modelo das próximas tabelas que detalham as funcionalidades escolhidas do jogo Stardew-Valley para serem implementadas no nosso projeto MUD.

No campo Observações, colocar onde vai ser implementado: banco ou frontend, e se for no banco, detalhes de como vai ser, por exemplo, por store procedure ou trigger, etc.

No campo prioridade, colocar: "Alta" - sem ela o jogo não funciona, "Média" - o jogo funciona incompleto ou "Baixa" - funcionalidade dispensável, serve só para deixar o jogo mais interessante.

No campo Status, colocar uma das seguintes opções: "não iniciada", "em andamento" ou "finalizado".

# Tabela 1 - Funcionalidades escolhidas

| ID  | Eu como...     | Gostaria de...                                         | Para...               | Observações                                        | Prioridade | Responsável                  | Status       |
| --- | -------------- | ------------------------------------------------------ | --------------------- | -------------------------------------------------- | ---------- | ---------------------------- | ------------ |
| 00  | Jogador        | Inicializar o jogo                                     | Poder começar a jogar | Deve ser implementado no frontend                  | Alta       | Nome de quem vai implementar | Não iniciado |
| 01  | Banco de Dados | Atualizar os dados do novo jogador na tabela "Jogador" | Para iniciar o jogo   | Deve ser implementado no banco por store procedure | Alta       | Nome de quem vai implementar | Não iniciado |

_Fonte:_ Autores, 2023

### Tabela 2 - Funcionalidades em Qualquer Tela

| ID  | Eu como...     | Gostaria de...                                                 | Para...                                                    | Observações                                        | Prioridade | Responsável                  | Status       |
| --- | -------------- | -------------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------------------------- | ---------- | ---------------------------- | ------------ |
| 02  | Jogador        | Iniciar o dia automaticamente quando energia = 5% ou hora = 02 | Manter o progresso do jogo mesmo se o jogador não dormir   | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 03  | Banco de Dados | Atualizar dados do jogador após iniciar o dia automaticamente  | Reiniciar o dia com energia = 100%, incrementar +1 no dia  | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 04  | Banco de Dados | Verificar se o dia chegou a 29 e reiniciar para dia 01         | Controlar o ciclo de dias e estações do jogo               | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 05  | Banco de Dados | Atualizar a estação do jogador após reiniciar para dia 01      | Registrar a mudança de estação                             | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 06  | Banco de Dados | Apagar todas as linhas da tabela Plantacao ao mudar a estação  | Limpar a tabela de plantações ao iniciar nova estação      | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 07  | Banco de Dados | Verificar se há plantações prontas para colher                 | Identificar e recompensar o jogador por plantações prontas | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 08  | Banco de Dados | Atualizar inventário após colher plantações                    | Registrar itens obtidos com a colheita de plantações       | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 09  | Banco de Dados | Seta energia para 100% novamente após colher plantações        | Garantir que o jogador esteja pronto para novas atividades | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 10  | Banco de Dados | Atualizar o horário com base no tempo jogado                   | Registrar a passagem do tempo durante o dia                | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 11  | Jogador        | Visualizar itens consumíveis disponíveis com efeitos           | Conferir opções de itens para consumo e seus efeitos       | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 12  | Jogador        | Escolher item consumível para comer efeito                     | Aumentar ou decrementar energia do jogador                 | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 13  | Jogador        | Visualizar aviso para ir dormir quando a hora é 00:00          | Receber alerta para dormir e manter o ciclo do jogo        | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 14  | Jogador        | Decidir ir dormir ou comer quando energia atinge 10%           | Escolher entre ir dormir ou comer para recuperar energia   | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |

_Fonte:_ Autores, 2023

### Tabela 3 - Funcionalidades da Primeira Tela

| ID  | Eu como...     | Gostaria de...                                                  | Para...                                                     | Observações                                        | Prioridade | Responsável                  | Status       |
| --- | -------------- | --------------------------------------------------------------- | ----------------------------------------------------------- | -------------------------------------------------- | ---------- | ---------------------------- | ------------ |
| 15  | Jogador        | Inicializar o jogo                                              | Poder começar a jogar                                       | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 16  | Banco de Dados | Atualizar os dados do novo jogador na tabela "Jogador"          | Para iniciar o jogo                                         | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 17  | Jogador        | Escolher um mundo                                               | Explorar diferentes ambientes                               | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 18  | Banco de Dados | Inserir dados do mundo escolhido na tabela "Mundo"              | Registrar a escolha do jogador                              | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 19  | Jogador        | Escolher uma região                                             | Explorar diferentes áreas no mundo escolhido                | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 20  | Banco de Dados | Inserir dados da região escolhida na tabela "Região join Mundo" | Registrar a escolha do jogador                              | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 21  | Banco de Dados | Inserir nova linha na tabela "Jogador"                          | Registrar o novo jogador                                    | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 22  | Banco de Dados | Inserir nova linha na tabela "Habilidade"                       | Registrar as habilidades do novo jogador                    | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 23  | Banco de Dados | Inserir linhas na tabela "Item-Inventário"                      | Registrar os itens iniciais do jogador                      | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 24  | Jogador        | Verificar status do jogador                                     | Conferir energia, quantidade de ouro e níveis de habilidade | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 25  | Jogador        | Listar itens do inventário                                      | Visualizar os itens que o jogador possui                    | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 26  | Jogador        | Confirmar mudança de região                                     | Prosseguir para a próxima região                            | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |

_Fonte:_ Autores, 2023

### Tabela 4 - Funcionalidades da Segunda Tela

| ID  | Eu como...     | Gostaria de...                                         | Para...                                                     | Observações                                        | Prioridade | Responsável                  | Status       |
| --- | -------------- | ------------------------------------------------------ | ----------------------------------------------------------- | -------------------------------------------------- | ---------- | ---------------------------- | ------------ |
| 27  | Jogador        | Inicializar o jogo                                     | Poder começar a jogar                                       | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 28  | Banco de Dados | Atualizar os dados do novo jogador na tabela "Jogador" | Para iniciar o jogo                                         | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 29  | Jogador        | Visualizar status do jogo                              | Conferir região, estação, dia e hora                        | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 30  | Jogador        | Visualizar status do jogador                           | Conferir energia, quantidade de ouro e níveis de habilidade | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 31  | Jogador        | Explorar descrição da região                           | Conhecer os locais fechados disponíveis                     | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 32  | Jogador        | Realizar coleta                                        | Coletar itens na região                                     | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 33  | Banco de Dados | Registrar coleta na tabela "Item-Inventário"           | Atualizar inventário do jogador                             | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 34  | Jogador        | Realizar plantação                                     | Plantar sementes na região                                  | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 35  | Banco de Dados | Registrar plantação na tabela "Plantacao"              | Atualizar dados de plantação do jogador                     | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 36  | Jogador        | Realizar pesca                                         | Pescar itens na região                                      | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 37  | Banco de Dados | Registrar pesca na tabela "Item_Inventario"            | Atualizar inventário do jogador com itens pescados          | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 38  | Jogador        | Realizar crafting                                      | Craftar itens com receitas disponíveis                      | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 39  | Banco de Dados | Atualizar inventário após crafting                     | Registrar itens craftados no inventário do jogador          | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 40  | Jogador        | Conversar com NPC                                      | Interagir com NPCs na região                                | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 41  | Jogador        | Realizar ações de combate/mineração                    | Explorar cavernas ou locais de combate na região            | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 42  | Banco de Dados | Atualizar local_fechado na tabela "Jogador"            | Registrar mudança para caverna ou local de combate          | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 43  | Jogador        | Acessar local fechado na região                        | Explorar locais fechados disponíveis na região              | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 44  | Banco de Dados | Atualizar local_fechado na tabela "Jogador"            | Registrar escolha do local fechado                          | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 45  | Jogador        | Mudar de região                                        | Explorar outras regiões disponíveis                         | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |

_Fonte:_ Autores, 2023

### Tabela 5 - Funcionalidades na Tela de Local Fechado

| ID  | Eu como...     | Gostaria de...                                                         | Para...                                                    | Observações                                        | Prioridade | Responsável                  | Status       |
| --- | -------------- | ---------------------------------------------------------------------- | ---------------------------------------------------------- | -------------------------------------------------- | ---------- | ---------------------------- | ------------ |
| 46  | Jogador        | Visualizar status do jogo: região, estação, dia e hora                 | Acompanhar o contexto do jogo                              | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 47  | Jogador        | Visualizar status do jogador: energia, qtdd-ouro, níveis de habilidade | Conferir meu progresso e recursos disponíveis              | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 48  | Jogador        | Visualizar descrição da região atual e do local fechado                | Entender o ambiente em que estou                           | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 49  | Jogador        | Escolher ação a ser realizada no local fechado                         | Interagir com o ambiente e realizar atividades específicas | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 50  | Jogador        | Na loja, visualizar o estoque para compras                             | Conferir itens disponíveis para compra                     | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 51  | Jogador        | Na loja, escolher itens para comprar e quantidade                      | Adquirir itens necessários                                 | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 52  | Banco de Dados | Verificar se jogador possui ouro suficiente para compra                | Garantir que o jogador tem recursos necessários            | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 53  | Banco de Dados | Atualizar inventário após compra                                       | Registrar itens adquiridos no inventário                   | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 54  | Banco de Dados | Atualizar estoque da loja após compra                                  | Atualizar quantidade de itens no estoque da loja           | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 55  | Jogador        | Escolher ação na caverna (minerar, combater, sair)                     | Participar de atividades específicas na caverna            | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 56  | Jogador        | Na caverna, visualizar itens disponíveis para mineração                | Conferir recursos disponíveis para mineração               | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 57  | Jogador        | Na caverna, participar da mineração                                    | Adquirir itens ao realizar a mineração                     | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 58  | Banco de Dados | Atualizar inventário após mineração                                    | Registrar itens minerados no inventário                    | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 59  | Banco de Dados | Incrementar habilidade de mineração após mineração                     | Melhorar habilidade de mineração do jogador                | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 60  | Jogador        | Escolher ação de combate na caverna                                    | Participar de combates contra monstros na caverna          | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 61  | Jogador        | Na caverna, visualizar monstros disponíveis para combate               | Conferir instâncias de monstros na caverna                 | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 62  | Jogador        | Na caverna, participar do combate                                      | Enfrentar monstros e obter recompensas                     | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 63  | Banco de Dados | Atualizar inventário após combate                                      | Registrar itens obtidos no inventário após o combate       | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 64  | Banco de Dados | Incrementar habilidade de combate após combate                         | Melhorar habilidade de combate do jogador                  | Deve ser implementado no banco por store procedure | -          | Nome de quem vai implementar | Não iniciado |
| 65  | Jogador        | Na casa do NPC, escolher NPC para interação                            | Interagir com NPCs na casa do NPC                          | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 66  | Jogador        | Na casa do NPC, visualizar fala do NPC                                 | Conferir diálogos e interagir com o NPC                    | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 67  | Jogador        | Na casa do NPC, escolher continuar dialogando ou sair                  | Continuar interação ou voltar para escolher outra ação     | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |
| 68  | Jogador        | Na casa do jogador, escolher ir dormir ou sair                         | Decidir se deseja dormir ou continuar explorando           | Deve ser implementado no frontend                  | -          | Nome de quem vai implementar | Não iniciado |

_Fonte:_ Autores, 2023
