# Decisão: baseline documental da skill DP

## Contexto

Os 16 anexos do GPT DP foram baixados autenticadamente em 2026-08-07 e tiveram
nome, tamanho e SHA-256 preservados. Em 2026-09-21, a inspeção somente leitura
reconfirmou os mesmos 16 nomes, mas não produziu novo download binário.

## Decisão

Usar os 16 arquivos de `knowledge/original/` como baseline documental
provisório e reversível da candidata 0.2.0. Todos entram na allowlist; não há a
contaminação cruzada observada na família Fiscal.

## Limites

Isto comprova a captura de 2026-08-07 e presença nominal atual, não igualdade
dos bytes online em 2026-09-21. O Knowledge é curadoria interna e não substitui
fonte oficial vigente ou CCT/ACT autenticada.

## Reversão

Se uma captura posterior produzir bytes diferentes, preservar a nova geração
separadamente, comparar arquivo a arquivo, executar P1–P6 e somente então mudar
a allowlist em nova versão. Não alterar o GPT para produzir igualdade.
