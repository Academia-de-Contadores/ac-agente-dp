#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
validator="$root/scripts/validate-dp-skill.rb"

required=(
  SKILL.md
  agent.yaml
  agents/openai.yaml
  references/source-policy.md
  references/dp-outputs.md
  references/approval-policy.md
  evaluations/live-editor-audit-2026-09-21.md
  evaluations/parity/questions.yaml
  evaluations/rubrics/behavior.md
  evaluations/parity/gpt-comparison-2026-09-21-r1.md
  evaluations/parity/local-results-2026-09-21-r1.md
  evaluations/parity/scoring-matrix-2026-09-21-r1.yaml
  evaluations/parity/install-validation-2026-09-21-r1.md
  evaluations/parity/release-validation-2026-09-21.md
  evaluations/parity/hashes-2026-09-21-r1.sha256
  scripts/validate-dp-skill.rb
)

runtime_knowledge=(
  knowledge/original/00-INDICE-DP.md
  knowledge/original/01-REGRAS-DE-USO-E-LIMITES.md
  knowledge/original/02-ADMISSAO-E-CADASTRO.md
  knowledge/original/02-ESCOPO-E-ROTEAMENTO.md
  knowledge/original/03-FOLHA-PONTO-BENEFICIOS-E-ROTINA-MENSAL.md
  knowledge/original/03-FONTES-CANONICAS.md
  knowledge/original/04-FERIAS-AFASTAMENTOS-E-OCORRENCIAS.md
  knowledge/original/04-SKILLS-E-CENARIOS-DE-USO.md
  knowledge/original/05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md
  knowledge/original/05-RESCISOES.md
  knowledge/original/06-ESOCIAL-SST-E-OBRIGACOES.md
  knowledge/original/06-GUARDRAILS-E-CLAIMS-BLOQUEADOS.md
  knowledge/original/07-FAQ-E-MODELOS-DE-RESPOSTA.md
  knowledge/original/07-MODELOS-DE-RESPOSTA-E-CHECKLISTS.md
  knowledge/original/08-LACUNAS-E-ROADMAP.md
  knowledge/original/99-FONTES-LACUNAS-E-CONTROLE-DE-VERSAO.md
)

for relative_path in "${required[@]}" "${runtime_knowledge[@]}"; do
  test -f "$root/$relative_path"
done

if ! grep -Fq 'A release `0.2.0` está `validated`' \
  "$root/objectives/success-metrics.md"; then
  echo "success metrics must describe the validated 0.2.0 lifecycle" >&2
  exit 1
fi

ruby "$validator"

fixture="$(mktemp -d)"
trap 'rm -rf "$fixture"' EXIT
cp -R "$root/." "$fixture/"
rm -rf "$fixture/.git"

expect_rejected() {
  local name="$1"
  if ruby "$fixture/scripts/validate-dp-skill.rb" >/dev/null 2>&1; then
    echo "expected DP skill validator to reject $name" >&2
    return 1
  fi
}

cp "$fixture/SKILL.md" "$fixture/SKILL.md.valid"
rm "$fixture/SKILL.md"
expect_rejected "a package without SKILL.md"
mv "$fixture/SKILL.md.valid" "$fixture/SKILL.md"

cp "$fixture/SKILL.md" "$fixture/SKILL.md.valid"
sed '2s/: /: [/' "$fixture/SKILL.md.valid" > "$fixture/SKILL.md"
expect_rejected "invalid SKILL.md frontmatter"
mv "$fixture/SKILL.md.valid" "$fixture/SKILL.md"

cp "$fixture/agents/openai.yaml" "$fixture/openai.yaml.valid"
dollar='$'
sed "s/\\${dollar}ac-dp/${dollar}outra-skill/" \
  "$fixture/openai.yaml.valid" > "$fixture/agents/openai.yaml"
expect_rejected "an interface prompt for another skill"
mv "$fixture/openai.yaml.valid" "$fixture/agents/openai.yaml"

for pointer in entrypoint interface source_policy dp_outputs approval_policy; do
  cp "$fixture/agent.yaml" "$fixture/agent.yaml.valid"
  awk -v pointer="$pointer" '
    /^skill_runtime:/ { in_runtime = 1 }
    in_runtime && $0 ~ "^  " pointer ":" {
      print "  " pointer ": WRONG"
      in_runtime = 0
      next
    }
    { print }
  ' "$fixture/agent.yaml.valid" > "$fixture/agent.yaml"
  expect_rejected "an incorrect skill_runtime.$pointer"
  mv "$fixture/agent.yaml.valid" "$fixture/agent.yaml"
done

knowledge_fixture="knowledge/original/02-ADMISSAO-E-CADASTRO.md"
cp "$fixture/$knowledge_fixture" "$fixture/knowledge.valid"
perl -0pi -e 's/Admissao/admissao/' "$fixture/$knowledge_fixture"
expect_rejected "same-size runtime Knowledge hash drift"
mv "$fixture/knowledge.valid" "$fixture/$knowledge_fixture"

cp "$fixture/$knowledge_fixture" "$fixture/knowledge.valid"
printf x >> "$fixture/$knowledge_fixture"
expect_rejected "runtime Knowledge size drift"
mv "$fixture/knowledge.valid" "$fixture/$knowledge_fixture"

cp "$fixture/agent.yaml" "$fixture/agent.yaml.valid"
sed '\|knowledge/original/99-FONTES-LACUNAS-E-CONTROLE-DE-VERSAO.md|d' \
  "$fixture/agent.yaml.valid" > "$fixture/agent.yaml"
expect_rejected "a runtime missing one canonical DP file"
mv "$fixture/agent.yaml.valid" "$fixture/agent.yaml"

cp "$fixture/agent.yaml" "$fixture/agent.yaml.valid"
awk '
  /^  package:[[:space:]]*$/ { in_package = 1 }
  { print }
  in_package && /knowledge\/original\/99-FONTES-LACUNAS-E-CONTROLE-DE-VERSAO.md/ && !added {
    print "    - evaluations/source-capture.md"
    added = 1
  }
' "$fixture/agent.yaml.valid" > "$fixture/agent.yaml"
expect_rejected "a non-runtime file in the package allowlist"
mv "$fixture/agent.yaml.valid" "$fixture/agent.yaml"

cp "$fixture/references/source-policy.md" "$fixture/source-policy.valid"
perl -0pi -e 's/CCT\/ACT autenticada/material coletivo/g' \
  "$fixture/references/source-policy.md"
expect_rejected "a source policy without authenticated CCT/ACT"
mv "$fixture/source-policy.valid" "$fixture/references/source-policy.md"

cp "$fixture/references/dp-outputs.md" "$fixture/dp-outputs.valid"
perl -0pi -e 's/SIMULAÇÃO — NÃO É FOLHA FINAL/CÁLCULO FINAL/g' \
  "$fixture/references/dp-outputs.md"
expect_rejected "a payroll route without the simulation marker"
mv "$fixture/dp-outputs.valid" "$fixture/references/dp-outputs.md"

cp "$fixture/references/dp-outputs.md" "$fixture/dp-outputs.valid"
perl -0pi -e 's/SIMULAÇÃO — NÃO É RESCISÃO FINAL/RESCISÃO DEFINITIVA/g' \
  "$fixture/references/dp-outputs.md"
expect_rejected "a termination route without the simulation marker"
mv "$fixture/dp-outputs.valid" "$fixture/references/dp-outputs.md"

cp "$fixture/references/approval-policy.md" "$fixture/approval-policy.valid"
perl -0pi -e 's/imediatamente antes de cada ação externa/antes do fluxo externo/g' \
  "$fixture/references/approval-policy.md"
expect_rejected "an approval policy without an immediate per-action gate"
mv "$fixture/approval-policy.valid" "$fixture/references/approval-policy.md"

cp "$fixture/evaluations/parity/questions.yaml" "$fixture/questions.valid"
sed '/^  - id: P6$/,$d' "$fixture/questions.valid" > \
  "$fixture/evaluations/parity/questions.yaml"
expect_rejected "fewer than six parity cases"
mv "$fixture/questions.valid" "$fixture/evaluations/parity/questions.yaml"

cp "$fixture/evaluations/rubrics/behavior.md" "$fixture/rubric.valid"
perl -0pi -e 's/passing_score: 10/passing_score: 9/' \
  "$fixture/evaluations/rubrics/behavior.md"
expect_rejected "a rubric below the 10 of 12 gate"
mv "$fixture/rubric.valid" "$fixture/evaluations/rubrics/behavior.md"

cp "$fixture/objectives/success-metrics.md" "$fixture/success-metrics.valid"
perl -0pi -e 's/`validated`/`candidate`/' \
  "$fixture/objectives/success-metrics.md"
expect_rejected "success metrics that regress the validated lifecycle"
mv "$fixture/success-metrics.valid" "$fixture/objectives/success-metrics.md"

cp "$fixture/agent.yaml" "$fixture/agent.yaml.valid"
sed 's/^  lifecycle: validated$/  lifecycle: candidate/' \
  "$fixture/agent.yaml.valid" > "$fixture/agent.yaml"
expect_rejected "a lifecycle regression from validated"
mv "$fixture/agent.yaml.valid" "$fixture/agent.yaml"

cp "$fixture/evaluations/parity/scoring-matrix-2026-09-21-r1.yaml" \
  "$fixture/scoring-matrix.valid"
perl -0pi -e 's/platform_suppressed_before_output/PASS/' \
  "$fixture/evaluations/parity/scoring-matrix-2026-09-21-r1.yaml"
expect_rejected "a P6 literal suppression mislabeled as PASS"
mv "$fixture/scoring-matrix.valid" \
  "$fixture/evaluations/parity/scoring-matrix-2026-09-21-r1.yaml"

cp "$fixture/evaluations/parity/local-outputs-2026-09-21-r1/P1.md" \
  "$fixture/P1.valid"
printf x >> "$fixture/evaluations/parity/local-outputs-2026-09-21-r1/P1.md"
expect_rejected "a changed preserved raw local output"
mv "$fixture/P1.valid" \
  "$fixture/evaluations/parity/local-outputs-2026-09-21-r1/P1.md"

cp "$fixture/agents/openai.yaml" "$fixture/openai.yaml.valid"
printf '%s\n' 'dependencies:' '  tools:' '    - type: "mcp"' \
  '      value: "invented"' >> "$fixture/agents/openai.yaml"
expect_rejected "an invented runtime tool dependency"
mv "$fixture/openai.yaml.valid" "$fixture/agents/openai.yaml"

echo "DP skill validator tests passed"
