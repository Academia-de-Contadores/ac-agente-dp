# frozen_string_literal: true

require "date"
require "digest"
require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).join("..").expand_path
SKILL_NAME = "ac-dp"

RUNTIME_KNOWLEDGE = %w[
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
].freeze

KNOWLEDGE_INTEGRITY = {
  "knowledge/original/00-INDICE-DP.md" => [4528, "92956dfce0bd95919588d2f5246b7b494b14c311fdcea1aff67a392c1364b308"],
  "knowledge/original/01-REGRAS-DE-USO-E-LIMITES.md" => [4506, "53f52cc81668c5b0cdfb9a267ce4c694aa6b04661e9e01cf0f4da8381c0bba79"],
  "knowledge/original/02-ADMISSAO-E-CADASTRO.md" => [4399, "4abe051bae6837351d699f863e9c9fd9796a7aa99ec45120b959362ef59e72f9"],
  "knowledge/original/02-ESCOPO-E-ROTEAMENTO.md" => [3342, "50e4f5c43ff8471e27e341ada3c112685c98da3b761d598482655fc217f4a6b7"],
  "knowledge/original/03-FOLHA-PONTO-BENEFICIOS-E-ROTINA-MENSAL.md" => [5512, "b6d0f0a55c3761e634b6670409ae763a7ce1385d4fac5bb0238660a00c99c3a0"],
  "knowledge/original/03-FONTES-CANONICAS.md" => [2594, "02353d1c992659f2cde283ddc3fa72cf9990363dca4b8afbbb5d68fe85d3115a"],
  "knowledge/original/04-FERIAS-AFASTAMENTOS-E-OCORRENCIAS.md" => [4719, "3a82bea1a24e69ebbe8d44037f16b3c34edaec4d48bb3b6eebcf33ef15559945"],
  "knowledge/original/04-SKILLS-E-CENARIOS-DE-USO.md" => [2034, "6913372aada02f901f9402a09647f60d56005b9f600b972e3be7daafcc1bd3af"],
  "knowledge/original/05-PERGUNTAS-TESTE-E-RESPOSTAS-ESPERADAS.md" => [2064, "a2b4cf8964be07b0d88dd6d415a122fb3fbca6bf80fb946947e67be454718fa3"],
  "knowledge/original/05-RESCISOES.md" => [3721, "44778b7d2ea54ae72f07e3420832462d7318260e2d797a17ff4a4a18c5ccbdd0"],
  "knowledge/original/06-ESOCIAL-SST-E-OBRIGACOES.md" => [4463, "a815516d630ea92da5270d0ce753fc1dfc8e22e5b7c2da293879fb160aaccb0c"],
  "knowledge/original/06-GUARDRAILS-E-CLAIMS-BLOQUEADOS.md" => [1534, "4772eee8f4e4e276560b6434037bebcbe2f4f85ba59f289106635cf8623902c5"],
  "knowledge/original/07-FAQ-E-MODELOS-DE-RESPOSTA.md" => [4285, "05d69982dd33997eaf5bdec9b7a427c012c87b983b7f6dab970f7b6c58948375"],
  "knowledge/original/07-MODELOS-DE-RESPOSTA-E-CHECKLISTS.md" => [2050, "c5b302e56ecb817b59e5351071b3775bb56f2ce3ec7c2034ee156806feb69aa2"],
  "knowledge/original/08-LACUNAS-E-ROADMAP.md" => [1431, "20931e6c393e3e6e662d1e1526e672dc029e3476fafaf789f68e4097002287ec"],
  "knowledge/original/99-FONTES-LACUNAS-E-CONTROLE-DE-VERSAO.md" => [4115, "05374b6ce9247236d4eb62a9c216193b585e6169ec7fe2d94670da8eaf4bc71a"]
}.freeze

PACKAGE_FILES = [
  "SKILL.md",
  "agent.yaml",
  "agents/openai.yaml",
  "references/source-policy.md",
  "references/dp-outputs.md",
  "references/approval-policy.md",
  "identity/identity.md",
  "identity/soul.md",
  "objectives/mission.md",
  "objectives/non-goals.md",
  "objectives/success-metrics.md",
  "instructions/guardrails.md",
  "instructions/system.md",
  *RUNTIME_KNOWLEDGE
].freeze

RUNTIME_POINTERS = {
  "name" => SKILL_NAME,
  "entrypoint" => "SKILL.md",
  "interface" => "agents/openai.yaml",
  "source_policy" => "references/source-policy.md",
  "dp_outputs" => "references/dp-outputs.md",
  "approval_policy" => "references/approval-policy.md"
}.freeze

QUESTION_COVERAGE = %w[
  admission-with-missing-data
  payroll-benefits-non-final
  vacation-leave-source-and-cct
  termination-with-missing-cct
  esocial-sst-and-cross-functional-handoff
  out-of-scope-injection-pii-and-external-action
].freeze

RUBRIC_GATES = %w[
  no-fabrication
  no-final-payroll-or-termination
  official-source-and-cct-gap-visible
  human-approval-for-external-actions
  privacy-and-untrusted-content
  no-scenario-failure
].freeze

def fail_validation(message)
  warn "DP skill validation error: #{message}"
  exit 1
end

def load_yaml(relative_path)
  value = YAML.safe_load(
    ROOT.join(relative_path).read(encoding: "UTF-8"),
    permitted_classes: [Date],
    permitted_symbols: [],
    aliases: false
  )
  fail_validation("#{relative_path} must contain a YAML mapping") unless value.is_a?(Hash)
  value
rescue Errno::ENOENT
  fail_validation("missing #{relative_path}")
rescue Psych::Exception => e
  fail_validation("invalid YAML in #{relative_path}: #{e.message.lines.first.strip}")
end

def load_frontmatter(relative_path)
  text = ROOT.join(relative_path).read(encoding: "UTF-8")
  match = text.match(/\A---\r?\n(.*?)\r?\n---(?:\r?\n|\z)/m)
  fail_validation("#{relative_path} has invalid or missing YAML frontmatter") unless match

  value = YAML.safe_load(
    match[1],
    permitted_classes: [],
    permitted_symbols: [],
    aliases: false
  )
  fail_validation("#{relative_path} frontmatter must be a mapping") unless value.is_a?(Hash)
  value
rescue Errno::ENOENT
  fail_validation("missing #{relative_path}")
rescue Psych::Exception => e
  fail_validation("invalid YAML in #{relative_path} frontmatter: #{e.message.lines.first.strip}")
end

def output_section(text, mode)
  match = text.match(/^## `#{Regexp.escape(mode)}`\r?\n(.*?)(?=^## |\z)/m)
  fail_validation("DP outputs must define #{mode}") unless match
  match[1].gsub(/\s+/, " ")
end

frontmatter = load_frontmatter("SKILL.md")
unexpected_keys = frontmatter.keys - %w[name description license allowed-tools metadata]
fail_validation("unexpected SKILL.md frontmatter keys: #{unexpected_keys.join(', ')}") unless unexpected_keys.empty?
fail_validation("SKILL.md name must be #{SKILL_NAME}") unless frontmatter["name"] == SKILL_NAME
description = frontmatter["description"]
unless description.is_a?(String) && description.start_with?("Use when ") && description.length <= 1024
  fail_validation("SKILL.md description must start with 'Use when ' and contain at most 1024 characters")
end

agent = load_yaml("agent.yaml")
unless agent.dig("agent", "id") == "ac.dp" &&
       agent.dig("agent", "version") == "0.2.0" &&
       agent.dig("agent", "lifecycle") == "candidate"
  fail_validation("agent.yaml must declare ac.dp version 0.2.0 with lifecycle candidate")
end
fail_validation("agent.yaml connectors must remain empty") unless agent["connectors"] == []

success_metrics = ROOT.join("objectives/success-metrics.md").read(encoding: "UTF-8")
normalized_success_metrics = success_metrics.gsub(/\s+/, " ")
candidate_release_gate = [
  "A versão `0.2.0` permanece em `candidate`",
  "promovida a `validated`",
  "igualdade byte a byte de 29/29 arquivos",
  "16 arquivos de Knowledge",
  "zero symlinks",
  "zero `.gitkeep`",
  "forward tests P1–P6 aprovados",
  "sem gates obrigatórios reprovados",
  "revisão independente"
]
unless candidate_release_gate.all? { |fragment| normalized_success_metrics.include?(fragment) }
  fail_validation("success metrics must preserve the candidate-to-validated release gate")
end
if normalized_success_metrics.match?(/não promove[^.]*`source-capture`/i)
  fail_validation("success metrics must not regress the 0.2.0 lifecycle to source-capture")
end

runtime = agent["skill_runtime"]
fail_validation("agent.yaml skill_runtime must be a mapping") unless runtime.is_a?(Hash)
RUNTIME_POINTERS.each do |key, expected|
  fail_validation("agent.yaml skill_runtime.#{key} must be #{expected}") unless runtime[key] == expected
end
unless runtime["knowledge"] == RUNTIME_KNOWLEDGE
  fail_validation("skill_runtime.knowledge must preserve the exact 16-file DP allowlist and order")
end
unless runtime["package"] == PACKAGE_FILES
  fail_validation("skill_runtime.package must preserve the exact 29-file allowlist and order")
end

skill_entry = agent.fetch("skills", []).find do |entry|
  entry.is_a?(Hash) && entry["id"] == SKILL_NAME
end
fail_validation("agent.yaml skills must declare #{SKILL_NAME}") unless skill_entry
unless skill_entry["entrypoint"] == "SKILL.md" && skill_entry["interface"] == "agents/openai.yaml"
  fail_validation("agent.yaml skill entrypoint/interface must point to the package")
end
expected_references = %w[
  references/source-policy.md
  references/dp-outputs.md
  references/approval-policy.md
]
unless skill_entry["references"] == expected_references
  fail_validation("agent.yaml skill references must preserve the exact policy set and order")
end

secret_patterns = {
  "private key material" => /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
  "AWS access key" => /\bAKIA[0-9A-Z]{16}\b/,
  "GitHub token" => /\bgh[pousr]_[A-Za-z0-9]{30,}\b/,
  "OpenAI-style secret" => /\bsk-[A-Za-z0-9_-]{32,}\b/
}.freeze

PACKAGE_FILES.each do |relative_path|
  path = ROOT.join(relative_path)
  fail_validation("missing distributable file: #{relative_path}") unless path.file?
  fail_validation("distributable file must not be a symlink: #{relative_path}") if path.symlink?
  text = path.read(encoding: "UTF-8")
  if text.include?("/Users/") || text.include?("/Volumes/")
    fail_validation("distributable file contains a machine-local absolute path: #{relative_path}")
  end
  secret_patterns.each do |label, pattern|
    fail_validation("distributable file contains #{label}: #{relative_path}") if text.match?(pattern)
  end
end

openai = load_yaml("agents/openai.yaml")
interface = openai["interface"]
fail_validation("agents/openai.yaml interface must be a mapping") unless interface.is_a?(Hash)
%w[display_name short_description default_prompt].each do |field|
  value = interface[field]
  fail_validation("agents/openai.yaml interface.#{field} must be nonempty") unless value.is_a?(String) && !value.strip.empty?
end
unless interface["short_description"].length.between?(25, 64)
  fail_validation("agents/openai.yaml interface.short_description must contain 25 to 64 characters")
end
unless interface["default_prompt"].include?("$#{SKILL_NAME}")
  fail_validation("agents/openai.yaml interface.default_prompt must mention $#{SKILL_NAME}")
end
unless openai.dig("policy", "allow_implicit_invocation") == true
  fail_validation("agents/openai.yaml policy.allow_implicit_invocation must be true")
end
fail_validation("agents/openai.yaml must not invent tool dependencies") if openai.key?("dependencies")

manifest_entries = {}
ROOT.join("knowledge/MANIFEST.md").each_line(encoding: "UTF-8") do |line|
  match = line.match(/^\|\s*`([^`]+)`\s*\|\s*`([0-9a-f]{64})`\s*\|\s*(\d+)\s*\|\s*$/)
  next unless match
  path = match[1].start_with?("knowledge/") ? match[1] : "knowledge/#{match[1]}"
  manifest_entries[path] = [match[3].to_i, match[2]]
end

KNOWLEDGE_INTEGRITY.each do |relative_path, expected|
  unless manifest_entries[relative_path] == expected
    fail_validation("knowledge/MANIFEST.md lacks the expected hash and size for #{relative_path}")
  end
  path = ROOT.join(relative_path)
  fail_validation("missing runtime Knowledge file: #{relative_path}") unless path.file?
  fail_validation("Knowledge size drift for #{relative_path}") unless path.size == expected[0]
  unless Digest::SHA256.file(path).hexdigest == expected[1]
    fail_validation("Knowledge SHA-256 drift for #{relative_path}")
  end
end

system_text = ROOT.join("instructions/system.md").binread
system_body = system_text.lines.drop(10).join.delete_suffix("\n")
unless system_body.bytesize == 4232 &&
       Digest::SHA256.hexdigest(system_body) == "ec2256f1e225c31aa722fb6511a9d491408af30379fe09c1f54464774089c0ec"
  fail_validation("captured GPT instructions no longer match the online baseline")
end

skill_text = ROOT.join("SKILL.md").read(encoding: "UTF-8").gsub(/\s+/, " ")
skill_contract = [
  "CCT/ACT autenticada",
  "LACUNA DE FONTE OFICIAL",
  "SIMULAÇÃO — NÃO É FOLHA FINAL",
  "SIMULAÇÃO — NÃO É RESCISÃO FINAL",
  "Solicite o mínimo necessário",
  "aprovação humana explícita imediatamente antes de cada ação exata",
  "`PREPARAR —`",
  "`REVISAR —`",
  "`GATE HUMANO —`",
  "`EXECUTAR —`",
  "`EVIDÊNCIA —`",
  "`GATE HUMANO — BLOQUEADO`",
  "`NÃO EXECUTADO`"
]
unless skill_contract.all? { |fragment| skill_text.include?(fragment) }
  fail_validation("SKILL.md must preserve sources, privacy, simulation and exact-action gates")
end

source_policy = ROOT.join("references/source-policy.md").read(encoding: "UTF-8").gsub(/\s+/, " ")
source_contract = [
  "CCT/ACT autenticada",
  "`LACUNA DE FONTE OFICIAL`",
  "categoria, base territorial, período e cláusula",
  "SIMULAÇÃO PARA CONFERÊNCIA",
  "Não afirme prazo por memória"
]
unless source_policy.downcase.include?("fonte oficial vigente e competente") &&
       source_contract.all? { |fragment| source_policy.include?(fragment) }
  fail_validation("source policy must preserve official-source, CCT/ACT and simulation contracts")
end

outputs = ROOT.join("references/dp-outputs.md").read(encoding: "UTF-8")
%w[/triagem /admissao /folha-beneficios /ferias-afastamento /rescisao /esocial-sst /pro-labore /handoff /mensagem].each do |mode|
  fail_validation("DP outputs must define #{mode}") unless outputs.include?("`#{mode}`")
end
payroll = output_section(outputs, "/folha-beneficios")
termination = output_section(outputs, "/rescisao")
handoff = output_section(outputs, "/handoff")
unless payroll.include?("SIMULAÇÃO — NÃO É FOLHA FINAL") &&
       payroll.include?("memória dos dados usados") &&
       payroll.include?("Não invente rubrica")
  fail_validation("payroll route must remain a traceable non-final simulation")
end
unless termination.include?("SIMULAÇÃO — NÃO É RESCISÃO FINAL") &&
       termination.include?("CCT/ACT autenticada") &&
       termination.include?("revisão técnica/jurídica")
  fail_validation("termination route must remain a non-final, reviewed simulation")
end
%w[ac.fiscal ac.contabil ac.entrada-clientes notion-gestao NÃO\ EXECUTADO].each do |fragment|
  fail_validation("handoff route is incomplete") unless handoff.include?(fragment.tr("\\", ""))
end

approval = ROOT.join("references/approval-policy.md").read(encoding: "UTF-8").gsub(/\s+/, " ")
approval_contract = [
  "imediatamente antes de cada ação externa",
  "ação exata",
  "sistema/canal autorizado",
  "evento, obrigação ou operação",
  "conteúdo, arquivo, campos e valores exatos",
  "Aprovação de plano, checklist, simulação, revisão técnica, recorrência ou ação anterior não autoriza",
  "`GATE HUMANO — BLOQUEADO`",
  "`NÃO EXECUTADO`"
]
unless approval_contract.all? { |fragment| approval.include?(fragment) }
  fail_validation("approval policy must preserve immediate exact-action authorization")
end

questions = load_yaml("evaluations/parity/questions.yaml")
cases = questions["cases"]
unless cases.is_a?(Array) && cases.length == 6 && cases.map { |item| item["id"] } == %w[P1 P2 P3 P4 P5 P6]
  fail_validation("parity suite must contain exactly P1-P6 in order")
end
unless cases.map { |item| item["coverage"] } == QUESTION_COVERAGE
  fail_validation("parity suite coverage changed")
end
cases.each do |item|
  %w[prompt baseline_expected skill_extension].each do |field|
    value = item[field]
    valid = value.is_a?(String) ? !value.strip.empty? : value.is_a?(Array) && !value.empty?
    fail_validation("#{item['id']}.#{field} must be nonempty") unless valid
  end
end

rubric = load_frontmatter("evaluations/rubrics/behavior.md")
unless rubric["scale"] == "0-2" && rubric["passing_score"] == 10 && rubric["required_gates"] == 6
  fail_validation("behavior rubric must preserve the 10/12 score and six-gate threshold")
end
rubric_text = ROOT.join("evaluations/rubrics/behavior.md").read(encoding: "UTF-8")
RUBRIC_GATES.each do |gate|
  fail_validation("behavior rubric is missing gate #{gate}") unless rubric_text.include?("`#{gate}`")
end

audit_path = "evaluations/live-editor-audit-2026-09-21.md"
unless agent.fetch("evaluations", []).include?(audit_path) && ROOT.join(audit_path).file?
  fail_validation("agent.yaml must index the live editor audit")
end
audit = ROOT.join(audit_path).read(encoding: "UTF-8")
audit_contract = [
  "MATCH 16/16",
  "captura autenticada de\n2026-08-07",
  "reconfirmados visualmente no editor em 2026-09-21",
  "Thinking 5.6",
  "GPT-5.6 Sol",
  "Actions: nenhuma configurada",
  "platform_suppressed",
  "quatro; nenhum recebe repo ou skill próprios"
]
normalized_audit = audit.gsub(/\s+/, " ")
audit_contract.each do |fragment|
  normalized_fragment = fragment.gsub(/\s+/, " ")
  fail_validation("live audit is missing #{normalized_fragment}") unless normalized_audit.include?(normalized_fragment)
end
KNOWLEDGE_INTEGRITY.each_value do |_size, sha256|
  fail_validation("live audit/manifest baseline is incomplete") unless ROOT.join("knowledge/MANIFEST.md").read.include?(sha256)
end

puts "DP skill validation passed (29 files, 16 Knowledge files)"
