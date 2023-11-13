## Histórico de versões

| Versão |    Data    | Descrição            | Autor                                               |
| :----: | :--------: | -------------------- | --------------------------------------------------- |
| `1.0`  | 13/11/2023| Criação do documento | [Edilberto Cantuaria](https://github.com/edilbertocantuaria)  |


## User Stories (Histórias de usuário adaptado)

Na tabela 1 consta um modelo das próximas tabelas que detalham as funcionalidades escolhidas do jogo Stardew-Valley para serem implementadas no nosso projeto MUD.

No campo Observações, colocar onde vai ser implementado: banco ou frontend, e se for no banco, detalhes de como vai ser, por exemplo, por store procedure ou trigger, etc.

No campo prioridade, colocar: "Alta" - sem ela o jogo não funciona, "Média" - o jogo funciona incompleto ou "Baixa" - funcionalidade dispensável, serve só para deixar o jogo mais interessante.

No campo Status, colocar uma das seguintes opções: "não iniciada", "em andamento" ou "finalizado".

<div align="center"><font size="3"><p style="text-align: center"><b>Tabela 1</b> - Funcionalidades escolhidas</p></font>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Eu como...</th>
            <th>gostaria de...</th>
            <th>para...</th>
            <th>Observações</th>
            <th>Prioridade</th>
            <th>Responsável</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>01</td>
            <td>Jogador</td>
            <td>inicializar o jogo</td>
            <td>poder começar a jogar</td>
            <td>Deve ser implementado no frontend</td>
            <td>Alta</td>
            <td>nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>02</td>
            <td>Banco de Dados</td>
            <td>atualizar os dados do novo jogador na tabela "Jogador"</td>
            <td>para iniciar o jogo</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td>Alta</td>
            <td>nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
</table>

<font size="3"><p style="text-align: center"><b>Fonte:</b> Autores, 2023</p></font>
</div>



<div align="center"><font size="3"><p style="text-align: center"><b>Tabela 2</b> - Funcionalidades da Primeira Tela</p></font>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Eu como...</th>
            <th>Gostaria de...</th>
            <th>Para...</th>
            <th>Observações</th>
            <th>Prioridade</th>
            <th>Responsável</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>01</td>
            <td>Jogador</td>
            <td>Inicializar o jogo</td>
            <td>Poder começar a jogar</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>02</td>
            <td>Banco de Dados</td>
            <td>Atualizar os dados do novo jogador na tabela "Jogador"</td>
            <td>Para iniciar o jogo</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>03</td>
            <td>Jogador</td>
            <td>Escolher um mundo</td>
            <td>Explorar diferentes ambientes</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>04</td>
            <td>Banco de Dados</td>
            <td>Inserir dados do mundo escolhido na tabela "Mundo"</td>
            <td>Registrar a escolha do jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>05</td>
            <td>Jogador</td>
            <td>Escolher uma região</td>
            <td>Explorar diferentes áreas no mundo escolhido</td>
            <td>Deve ser implementado no frontend</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>06</td>
            <td>Banco de Dados</td>
            <td>Inserir dados da região escolhida na tabela "Região join Mundo"</td>
            <td>Registrar a escolha do jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>07</td>
            <td>Banco de Dados</td>
            <td>Inserir nova linha na tabela "Jogador"</td>
            <td>Registrar o novo jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>08</td>
            <td>Banco de Dados</td>
            <td>Inserir nova linha na tabela "Habilidade"</td>
            <td>Registrar as habilidades do novo jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>09</td>
            <td>Banco de Dados</td>
            <td>Inserir linhas na tabela "Item-Inventário"</td>
            <td>Registrar os itens iniciais do jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>10</td>
            <td>Jogador</td>
            <td>Verificar status do jogador</td>
            <td>Conferir energia, quantidade de ouro e níveis de habilidade</td>
            <td>Deve ser implementado no frontend</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>11</td>
            <td>Jogador</td>
            <td>Listar itens do inventário</td>
            <td>Visualizar os itens que o jogador possui</td>
            <td>Deve ser implementado no frontend</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>12</td>
            <td>Jogador</td>
            <td>Confirmar mudança de região</td>
            <td>Prosseguir para a próxima região</td>
            <td>Deve ser implementado no frontend</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
</table>

<font size="3"><p style="text-align: center"><b>Fonte:</b> Autores, 2023</p></font>
</div>


<div align="center"><font size="3"><p style="text-align: center"><b>Tabela 3</b> - Funcionalidades da Segunda Tela</p></font>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Eu como...</th>
            <th>Gostaria de...</th>
            <th>Para...</th>
            <th>Observações</th>
            <th>Prioridade</th>
            <th>Responsável</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>01</td>
            <td>Jogador</td>
            <td>Inicializar o jogo</td>
            <td>Poder começar a jogar</td>
            <td>Deve ser implementado no frontend</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>02</td>
            <td>Banco de Dados</td>
            <td>Atualizar os dados do novo jogador na tabela "Jogador"</td>
            <td>Para iniciar o jogo</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> -</td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>03</td>
            <td>Jogador</td>
            <td>Visualizar status do jogo</td>
            <td>Conferir região, estação, dia e hora</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>04</td>
            <td>Jogador</td>
            <td>Visualizar status do jogador</td>
            <td>Conferir energia, quantidade de ouro e níveis de habilidade</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>05</td>
            <td>Jogador</td>
            <td>Explorar descrição da região</td>
            <td>Conhecer os locais fechados disponíveis</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>06</td>
            <td>Jogador</td>
            <td>Realizar coleta</td>
            <td>Coletar itens na região</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>07</td>
            <td>Banco de Dados</td>
            <td>Registrar coleta na tabela "Item-Inventário"</td>
            <td>Atualizar inventário do jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>08</td>
            <td>Jogador</td>
            <td>Realizar plantação</td>
            <td>Plantar sementes na região</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>09</td>
            <td>Banco de Dados</td>
            <td>Registrar plantação na tabela "Plantacao"</td>
            <td>Atualizar dados de plantação do jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>10</td>
            <td>Jogador</td>
            <td>Realizar pesca</td>
            <td>Pescar itens na região</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>11</td>
            <td>Banco de Dados</td>
            <td>Registrar pesca na tabela "Item_Inventario"</td>
            <td>Atualizar inventário do jogador com itens pescados</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>12</td>
            <td>Jogador</td>
            <td>Realizar crafting</td>
            <td>Craftar itens com receitas disponíveis</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>13</td>
            <td>Banco de Dados</td>
            <td>Atualizar inventário após crafting</td>
            <td>Registrar itens craftados no inventário do jogador</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>14</td>
            <td>Jogador</td>
            <td>Conversar com NPC</td>
            <td>Interagir com NPCs na região</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>15</td>
            <td>Jogador</td>
            <td>Realizar ações de combate/mineração</td>
            <td>Explorar cavernas ou locais de combate na região</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>16</td>
            <td>Banco de Dados</td>
            <td>Atualizar local_fechado na tabela "Jogador"</td>
            <td>Registrar mudança para caverna ou local de combate</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>17</td>
            <td>Jogador</td>
            <td>Acessar local fechado na região</td>
            <td>Explorar locais fechados disponíveis na região</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>18</td>
            <td>Banco de Dados</td>
            <td>Atualizar local_fechado na tabela "Jogador"</td>
            <td>Registrar escolha do local fechado</td>
            <td>Deve ser implementado no banco por store procedure</td>
            <td> - </td>
            <td>Nome de quem vai implementar</td>
            <td>Não iniciado</td>
        </tr>
    </tbody>
    <tbody>
        <tr>
            <td>19</td>
            <td>Jogador</td>
            <td>Mudar de região</td>
            <td>Explorar outras regiões disponíveis</td>
            <td>Deve ser implementado no frontend</td>
            <td> - </td>

</table>

<font size="3"><p style="text-align: center"><b>Fonte:</b> Autores, 2023</p></font>
</div>


