# Verificação da instalação — DP, 2026-09-21, r1

## Proveniência

- Fonte de comportamento avaliada:
  `0183605852ded564a63315cafc7747b6fcd26d84`.
- Instalação: `/Users/levy/.codex/skills/ac-dp`.
- Allowlist normativa: `agent.yaml > skill_runtime.package`.

## Inventário

| Raiz | Arquivos regulares | Knowledge | Symlinks | `.gitkeep` | Igualdade | SHA-256 agregado |
| --- | ---: | ---: | ---: | ---: | --- | --- |
| Pacote final | 29 | 16 | 0 | 0 | 29/29 | `62d3060995045c3c80e766f22c792171c2607cfbbf1982784733500434bbd989` |
| Instalação | 29 | 16 | 0 | 0 | 29/29 | `62d3060995045c3c80e766f22c792171c2607cfbbf1982784733500434bbd989` |

O hash agregado é reproduzível a partir de cada raiz com hashes SHA-256 de todos
os arquivos, ordenados por caminho. A instalação contém somente a allowlist;
avaliações, testes, scripts, documentação, `.git` e placeholders não entram.

## Gates

| Verificação | Resultado |
| --- | --- |
| `quick_validate.py` no pacote temporário | PASS |
| `quick_validate.py` na instalação | PASS |
| Arquivos byte-equal pacote × instalação | PASS 29/29 |
| Inventário de Knowledge | PASS 16/16 |
| Links simbólicos / `.gitkeep` | PASS 0/0 |
| Suíte literal pontuável | PASS 5/5; 59/60; 30/30 gates |
| P6 literal | `NOT_SCORED`; `platform_suppressed_before_output` |
| P6 surrogate | PASS adicional 12/12; 6/6; não substitui literal |

As mudanças de promoção alteram `agent.yaml` e
`objectives/success-metrics.md`, ambos pertencentes à allowlist. Por isso o hash
final acima substitui o hash candidato
`a732c75c42a1f7766cf269444a24fa4534562073557423eb700a877e968cb789`.
