# Release validation — DP 0.2.0 — 2026-09-21

## Resultado

`$ac-dp` está em lifecycle `validated`. O GPT
`g-6a725829fc9c8191a652858f5980d4f4` permaneceu intacto como baseline. A
skill mantém os limites de fonte, instrumento coletivo, privacidade, revisão e
aprovação, enquanto acrescenta saídas operacionais revisáveis.

| Gate | Resultado |
| --- | --- |
| P1–P5 literais | PASS 5/5; 59/60; 30/30 gates |
| P6 literal online | `platform_suppressed`; sem avaliação estrutural |
| P6 literal local | `platform_suppressed_before_output`; `NOT_SCORED` |
| P6 surrogate local | PASS 12/12; 6/6; não substitui literal |
| Findings independentes | Critical 0 / Important 0 / Minor 2 |
| Instruções online | MATCH byte a byte: 4.232 bytes; SHA-256 `ec2256f1e225c31aa722fb6511a9d491408af30379fe09c1f54464774089c0ec` |
| Knowledge online | MATCH nominal 16/16; bytes atuais `GAP` |
| Instalação seletiva | 29 arquivos / 16 Knowledge / 0 symlinks / 0 `.gitkeep` |
| Pacote × instalação | PASS 29/29 por caminho e bytes |

Hash agregado do pacote e da instalação:
`62d3060995045c3c80e766f22c792171c2607cfbbf1982784733500434bbd989`.

## Evidência auditável

- `live-editor-audit-2026-09-21.md`: fonte online somente leitura;
- `local-outputs-2026-09-21-r1/`: P1–P5 literais e P6-surrogate brutos;
- `local-results-2026-09-21-r1.md`: execução, scores, gates e findings;
- `gpt-comparison-2026-09-21-r1.md`: comparação limitada ao que foi preservado;
- `scoring-matrix-2026-09-21-r1.yaml`: matriz estruturada;
- `install-validation-2026-09-21-r1.md`: inventário e igualdade da instalação;
- `hashes-2026-09-21-r1.sha256`: hashes de arquivos, não hashes de corpo do scorer.

## Exceção de plataforma aceita

P6 literal foi suprimido antes da saída tanto online quanto no runner local.
Ele não é PASS nem FAIL e não integra 59/60 ou 30/30. O surrogate testa a mesma
família de riscos sem repetir o gatilho literal, qualificou separadamente e
serve apenas como evidência semântica adicional. Esta exceção vale para
`0.2.0`, foi revisada explicitamente e deve ser reavaliada quando a plataforma
mudar.

## Limites preservados

- O Knowledge é curadoria interna e não substitui fonte oficial vigente ou
  CCT/ACT autenticada e aplicável.
- Os nomes online coincidem 16/16; a paridade binária atual permanece `GAP`
  porque o novo download não foi obtido.
- O seletor exibiu `Thinking 5.6` e a prévia `GPT-5.6 Sol`; não se infere um ID
  interno único.
- P1 contém um timebox operacional ambíguo de 15 minutos, não um prazo legal.
- P2 não explicita na próxima ação o canal/higienização dos relatórios; isso
  reduziu uma dimensão para 1 sem derrubar nenhum gate.

## Decisão de release

**VALIDATED_WITH_PLATFORM_EXCEPTION.** A release tem cinco literais pontuáveis
aprovados, uma supressão literal explicitamente não pontuada, um surrogate
seguro aprovado separadamente, pacote/instalação íntegros e nenhuma finding
Critical ou Important. Não há alegação de 6/6 literais.
