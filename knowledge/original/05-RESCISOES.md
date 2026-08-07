---
title: 05 RESCISOES
type: knowledge-note
status: draft
produto: Desafio Contadora CEO com IA
pilar: agentes
departamento: dp
fonte_tipo: knowledge_pack
origem: knowledge/dp
data_criacao: 2026-07-04
data_consulta: 2026-07-04
entra_no_rag: reference_only
confiabilidade: interna_curada
tags:
  - academia-contadores/dcceo/agentes
---

# Rescisoes

Tags: [DP:RESCISAO] [DP:AVISO] [DP:FGTS] [DP:ESTABILIDADE] [DP:JUSTACAUSA]

Fontes internas: `GUIA_COMPLETO_DP_2025`, `MODULO_07_RESCISOES`.

## Quando Usar

Use este modulo para:

- pedido de demissao;
- dispensa sem justa causa;
- justa causa;
- termino de contrato;
- rescisao antecipada;
- acordo;
- falecimento;
- encerramento da empresa;
- aviso previo;
- FGTS rescisorio;
- seguro-desemprego;
- estabilidade;
- data-base;
- exame demissional.

## Regra Mestra

Rescisao sempre exige revisao humana antes de fechar.

O agente pode:

- organizar dados;
- listar verbas provaveis;
- montar checklist;
- apontar riscos;
- preparar resposta revisavel.

O agente nao pode:

- fechar calculo oficial;
- autorizar justa causa;
- garantir ausencia de multa;
- validar pagamento;
- dispensar consulta a CCT/ACT;
- afirmar que nao ha estabilidade sem revisar.

## Dados Minimos

Antes de orientar:

- tipo de rescisao;
- quem tomou a iniciativa;
- data de admissao;
- data de desligamento;
- aviso previo trabalhado, indenizado ou dispensado;
- salario;
- medias;
- contrato de experiencia ou prazo determinado;
- ferias vencidas/proporcionais;
- 13o;
- extrato FGTS;
- estabilidade;
- afastamentos;
- CCT/ACT;
- data-base;
- exame demissional;
- pensao judicial;
- seguro-desemprego;
- prazo de pagamento;
- eventos no sistema.

## Checklist Antes De Calcular

1. Confirmar motivo real do desligamento.
2. Confirmar modalidade da rescisao.
3. Solicitar extrato de FGTS para fins rescisorios.
4. Verificar ferias.
5. Verificar 13o.
6. Verificar medias.
7. Verificar estabilidade.
8. Verificar afastamentos.
9. Verificar CCT/ACT e data-base.
10. Verificar exame demissional.
11. Conferir aviso previo e sua projecao.
12. Conferir prazo de pagamento.
13. Gerar simulacao no sistema.
14. Revisar com responsavel antes de enviar ao cliente.

## Justa Causa

Classifique como `HUMAN_REVIEW`.

Resposta segura:

> Justa causa e tema de alto risco. O agente pode organizar os fatos, documentos e perguntas, mas nao deve autorizar a aplicacao. Reuna evidencias, historico, comunicacoes, CCT/ACT e submeta ao responsavel tecnico/juridico.

## Estabilidade

Verifique antes de qualquer rescisao:

- gestante;
- acidente;
- CIPA;
- dirigente sindical;
- afastamento previdenciario;
- pre-aposentadoria, se prevista em CCT/ACT;
- data-base;
- outras estabilidades previstas em norma coletiva.

## Aviso Previo

Antes de orientar:

- confirmar modalidade;
- periodo trabalhado ou indenizado;
- reducao de jornada/dias;
- projecao;
- reflexo em data-base;
- impacto em ferias e 13o;
- CCT/ACT.

## Primeiro Prompt Seguro

> Monte um checklist revisavel para esta rescisao. Dados conhecidos: [sem dados pessoais]. Separe modalidade, dados faltantes, verbas provaveis, estabilidade, aviso previo, FGTS, CCT/ACT, prazos e pontos de revisao humana. Nao entregue valor final nem autorize pagamento.

## Modelo De Resposta Para Aluna

> Eu consigo te ajudar a organizar a rescisao, mas nao vou fechar valor final aqui. Primeiro confirme modalidade, datas, aviso, salario/medias, ferias, 13o, FGTS, estabilidade, CCT/ACT e exame demissional. Depois rode no sistema e revise antes de enviar ao cliente.

## Nao Responder Assim

Evite:

- "pode aplicar justa causa";
- "nao tem estabilidade";
- "a rescisao deu X";
- "pode pagar";
- "nao precisa de exame";
- "a CCT nao muda nada";
- "sem risco".

