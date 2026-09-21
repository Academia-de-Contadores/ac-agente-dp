# Saídas operacionais de Departamento Pessoal

Escolha somente os formatos úteis ao pedido. Toda saída distingue fatos,
evidências, dados faltantes, hipóteses, fonte/CCT e decisão humana. Use
`[A VALIDAR]` para campos sem suporte.

## `/triagem`

Entregue `Leitura curta | Rota | Escopo | Fatos | Dados pessoais a higienizar |
Dados faltantes | Fonte/CCT/status | Risco | Próxima ação segura`.

## `/admissao`

Entregue no turno atual uma matriz com `Campo | Informado | Evidência | Lacuna |
Responsável`. Cubra empresa, identificação anonimizada, data, contrato, cargo e
CBO, salário, jornada, local, categoria/sindicato, CCT/ACT, ASO, documentos,
benefícios, cadastro no sistema e evento provável do eSocial. Não afirme que a
admissão foi registrada ou que um código/evento foi validado.

## `/folha-beneficios`

Comece qualquer cálculo parcial com `SIMULAÇÃO — NÃO É FOLHA FINAL`. Organize:

1. competência, empresa e população da folha;
2. admissões, desligamentos, férias e afastamentos;
3. ponto, jornada, faltas, horas e banco;
4. proventos, descontos, benefícios, pensões e eventos variáveis;
5. parâmetros, tabelas e CCT/ACT a confirmar;
6. reconciliação entre ponto, folha, eSocial, DCTFWeb e FGTS Digital;
7. memória dos dados usados, hipóteses e itens não incluídos;
8. revisão técnica e evidências antes de fechamento, guia ou pagamento.

Não invente rubrica, incidência, alíquota, tabela, prazo ou valor final.

## `/ferias-afastamento`

Separe o caso em férias, atestado, afastamento previdenciário, maternidade,
acidente/SST ou outra ocorrência. Entregue datas informadas, período
aquisitivo/concessivo, saldo, documentos, CCT/ACT, estabilidade, evento
provável, fonte oficial a conferir, responsável e critério de conclusão. Não
afirme data, pagamento, retorno, estabilidade ou evento definitivo sem suporte.

## `/rescisao`

Comece qualquer número com `SIMULAÇÃO — NÃO É RESCISÃO FINAL`. Entregue no
turno atual:

- modalidade e iniciativa `[A VALIDAR]`;
- admissão, desligamento, aviso e projeção;
- salário, médias, adicionais, férias, 13º, faltas e pensão;
- FGTS, exame, seguro-desemprego e eventos do sistema;
- estabilidade, afastamentos, data-base e CCT/ACT autenticada;
- verbas prováveis, sem valor final quando faltarem dados;
- memória da simulação, conferência no sistema e revisão técnica/jurídica;
- fonte oficial específica a localizar e evidência esperada;
- estado de eventual pagamento/transmissão.

Justa causa e estabilidade nunca são autorizadas pela skill. Não dê prazo ou
valor final sem fonte, instrumento coletivo, dados completos e revisão.

## `/esocial-sst`

Entregue `Ocorrência | Evento provável [A VALIDAR] | Data do fato | Documentos |
Fonte vigente | Profissional responsável | Sistema/status | Risco | Próximo
passo`. Para acidente, CAT, ASO, PGR, PCMSO, LTCAT, S-2210, S-2220 ou S-2240,
não conclua prazo, dispensa, ausência de risco ou responsabilidade técnica sem
fonte e documentos. Diferencie preparar dados, revisar, transmitir e guardar
recibo.

## `/pro-labore`

Organize cadastro, competência, valor deliberado, remuneração, eventos de
folha/eSocial, DCTFWeb previdenciária e evidências. Encaminhe reflexos
tributários para `ac.fiscal` e contabilização para `ac.contabil`. Não escolha
valor, conclua incidência ou afirme lançamento sem validação.

## `/handoff`

Use este contrato:

```markdown
Destino: [ac.fiscal | ac.contabil | ac.entrada-clientes | notion-gestao]
Motivo: [sinal que saiu ou cruza o escopo]
Fatos e documentos higienizados: [lista]
Trabalho de DP já preparado: [lista]
Dados pessoais restritos/canal: [lista sem expor valores]
Lacunas e fontes/CCT: [lista]
Risco e urgência: [sem inventar prazo]
Pergunta técnica: [pergunta]
Responsável e critério de retorno: [pessoa/papel e evidência]
```

O handoff não significa execução da outra equipe. Quando o fluxo incluir
alteração, transmissão, envio ou pagamento, acrescente os cinco estados de
`references/approval-policy.md` e mantenha `NÃO EXECUTADO` até gate e evidência.

## `/mensagem`

Produza rascunho sem dado pessoal desnecessário, explicando o que foi conferido,
o que falta, impacto prático, prazo somente se sustentado e próximo passo. Até
aprovação do conteúdo, destinatário e canal exatos, marque `NÃO ENVIADA`.
