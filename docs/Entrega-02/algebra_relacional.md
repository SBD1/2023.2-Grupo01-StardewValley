<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

# Álgebra Relacional

## Consultar o id e a descrição de uma estação específica:
$$
\sigma_{nome='Primavera'}(\text{Estacao}) \rightarrow \Pi_{id\_estacao, descricao}(\sigma_{nome='Primavera'}(\text{Estacao}))
$$

## Consultar o id de um tipo de item específico:
$$
\text{Item} \bowtie_{\text{Item.id\_tipo\_item} = \text{Tipo\_Item.id\_tipo\_item} \land \text{Tipo\_Item.nome\_tipo\_item} = 'Semente'} \text{Tipo\_Item} \rightarrow \Pi_{\text{Item.id\_item}}
$$

## Consultar o id de um local fechado específico:
$$
\text{Local\_Fechado} \bowtie_{\text{Local\_Fechado.id\_local\_fechado} = \text{Tipo\_Local\_Fechado.id\_tipo\_local\_fechado} \land \text{Tipo\_Local\_Fechado.nome\_tipo\_local\_fechado} = 'Loja'} \text{Tipo\_Local\_Fechado} \rightarrow \Pi_{\text{Local\_Fechado.id\_local\_fechado}}
$$

## Consultar o id de um mundo específico:
$$
\sigma_{nome='Fazenda'}(\text{Mundo}) \rightarrow \Pi_{id\_mundo}(\sigma_{nome='Fazenda'}(\text{Mundo}))
$$

## Consultar o id e a descrição de uma arma específica:
$$
\sigma_{nome='espada'}(\text{Arma}) \rightarrow \Pi_{id\_arma, descricao}(\sigma_{nome='espada'}(\text{Arma}))
$$

## Consultar a descrição, o dano e a finalidade de uma arma específica:
$$
\sigma_{id\_arma=1}(\text{Arma}) \rightarrow \Pi_{descricao, dano, finalidade}(\sigma_{id\_arma=1}(\text{Arma}))
$$

## Consultar o id de um artesanato específico:
$$
\sigma_{nome='Espantalho'}(\text{Artesanato}) \rightarrow \Pi_{id\_artesanato, descricao}(\sigma_{nome='Espantalho'}(\text{Artesanato}))
$$

## Consultar o id e a descrição de um consumível específico:
$$
\sigma_{nome='Omelete'}(\text{Consumivel}) \rightarrow \Pi_{id\_consumivel, descricao}(\sigma_{nome='Omelete'}(\text{Consumivel}))
$$

## Consultar o id, valor e tipo de um efeito de um item específico:
$$
\sigma_{id\_item=2}(\text{Efeito}) \rightarrow \Pi_{id\_efeito, tipo, valor}(\sigma_{id\_item=2}(\text{Efeito}))
$$

## Consultar o id, a descrição e a finalidade de uma ferramenta específica:
$$
\sigma_{nome='enxada'}(\text{Ferramenta}) \rightarrow \Pi_{id\_ferramenta, descricao, finalidade}(\sigma_{nome='enxada'}(\text{Ferramenta}))
$$

## Consultar o id e a descrição de uma vestimenta específica:
$$
\sigma_{nome='Vestido de Baile de Inverno'}(\text{Vestimenta}) \rightarrow \Pi_{id\_vestimenta, descricao}(\sigma_{nome='Vestido de Baile de Inverno'}(\text{Vestimenta}))
$$

## Consultar o id e as informações de um monstro específico:
$$
\sigma_{nome='Serpente'}(\text{Monstro}) \rightarrow \Pi_{id\_monstro, id\_drop, dano, defesa, saude\_maxima}(\sigma_{nome='Serpente'}(\text{Monstro}))
$$

## Consultar o id e as informações de uma semente específica:
$$
\text{Informacao\_Semente} \bowtie_{\text{Informacao\_Semente.nome} = 'Semente de Couve-flor'} \text{Semente} \rightarrow \Pi_{\text{Semente.id\_semente}, id\_estacao, descricao, valor\_venda, dias\_para\_crescer}
$$

## Consultar o id e as informações de uma missão específica:
$$
\sigma_{nome='Plantando as Sementes'}(\text{Missao}) \rightarrow \Pi_{id\_missao, id\_estacao, descricao}(\sigma_{nome='Plantando as Sementes'}(\text{Missao}))
$$

## Consultar o id e o mundo de uma região específica:
$$
\sigma_{nome='Vila Pelicanos'}(\text{Regiao}) \rightarrow \Pi_{id\_regiao, mundo}(\sigma_{nome='Vila Pelicanos'}(\text{Regiao}))
$$

## Consultar o id e as informações de um NPC específico:
$$
\sigma_{nome='Willy'}(\text{NPC}) \rightarrow \Pi_{id\_npc, id\_regiao, id\_local\_fechado, profissao}(\sigma_{nome='Willy'}(\text{NPC}))
$$

## Consultar o id e as informações de uma caverna específica:
$$
\sigma_{nome='Caverna das Minhocas'}(\text{Caverna}) \rightarrow \Pi_{id\_local\_fechado, id\_regiao, descricao}(\sigma_{nome='Caverna das Minhocas'}(\text{Caverna}))
$$

## Consultar o id e as informações de uma cabana_NPC específica:
$$
\sigma_{nome='Cabana de Robin'}(\text{Cabana\_NPC}) \rightarrow \Pi_{id\_local\_fechado, id\_regiao, descricao}(\sigma_{nome='Cabana de Robin'}(\text{Cabana\_NPC}))
$$

## Consultar o id e as informações de uma loja específica:
$$
\sigma_{nome='Loja de Linus'}(\text{Loja}) \rightarrow \Pi_{id\_loja, id\_npc, id\_regiao, descricao}(\sigma_{nome='Loja de Linus'}(\text{Loja}))
$$

## Consultar o id e as informações de um jogador específico:
$$
\sigma_{nome='Marcus'}(\text{Jogador}) \rightarrow \Pi_{id\_jogador, id\_local\_fechado, id\_regiao, id\_estacao, id\_missao, saude, energia, dia, hora, qtdd\_ouro}

(\sigma_{nome='Marcus'}(\text{Jogador}))
$$

## Consultar a receita de um artesanato específico:
$$
\text{Item\_Receita} \bowtie_{\text{Item\_Receita.id\_artesanato} = \text{Artesanato.id\_artesanato} \land \text{Artesanato.nome} = 'Tear'} \text{Artesanato} \rightarrow \Pi_{id\_item, qtdd}
$$

## Consultar Habilidades:
$$
\text{Habilidade} \bowtie_{\text{Habilidade.id\_jogador} = \text{Jogador.id\_jogador} \land \text{Habilidade.id\_jogador} = 2} \text{Jogador} \rightarrow \Pi_{nivel\_coleta, nivel\_cultivo, nivel\_mineracao, nivel\_pesca, nivel\_combate}
$$

## Consultar o id e a fala de um diálogo específico:
$$
\text{NPC} \bowtie_{\text{NPC.id\_npc} = \text{Dialogo.id\_npc} \land \text{NPC.nome} = 'Marlon'} \text{Dialogo} \rightarrow \Pi_{id\_dialogo, fala}
$$

## Consultar o id e as informações de uma cabana_jogador específica:
$$
\text{Cabana\_Jogador} \bowtie_{\text{Cabana\_Jogador.id\_jogador} = \text{Jogador.id\_jogador} \land \text{Jogador.nome} = 'Zenilda'} \text{Jogador} \rightarrow \Pi_{Cabana\_Jogador.id\_local\_fechado, Cabana\_Jogador.id\_regiao, Cabana\_Jogador.nome, Cabana\_Jogador.descricao}
$$

## Consultar o id de um item_inventario específico:
$$
\text{Item\_Inventario} \bowtie_{\text{Item\_Inventario.id\_item} = \text{Item.id\_item} \land \text{Item\_Inventario.id\_jogador} = 3} \text{Item} \rightarrow \Pi_{Item\_Inventario.id\_item, \text{SUM}(qtdd)} \text{Item\_Inventario} \text{GROUP BY Item\_Inventario.id\_item}
$$

## Consultar o id e as informações de um item_estoque_loja específico:
$$
\text{Item\_Estoque\_Loja} \bowtie_{\text{Tipo\_Item.id\_tipo\_item} = \text{Item.id\_tipo\_item} \land \text{Item.id\_item} = \text{Item\_Estoque\_Loja.id\_item} \land \text{Item\_Estoque\_Loja.id\_loja} = 1} \text{Tipo\_Item} \rightarrow \Pi_{Tipo\_Item.nome\_tipo\_item, Item\_Estoque\_Loja.preco}
$$

## Consultar o id e as informações de uma instância de monstro específica:
$$
\text{Monstro} \bowtie_{\text{Monstro.id\_monstro} = \text{Instancia\_Monstro.id\_monstro} \land \text{Instancia\_Monstro.id\_caverna} = 2} \text{Instancia\_Monstro} \rightarrow \Pi_{Instancia\_Monstro.id\_monstro, Monstro.nome, Monstro.descricao, Instancia\_Monstro.id\_drop, Instancia\_Monstro.dano, Instancia\_Monstro.defesa, Instancia\_Monstro.saude\_maxima, Instancia\_Monstro.saude}
$$