# Como usar a skill de Departamento Pessoal

## Começo rápido

Escreva `Use $ac-dp` e descreva o caso sem CPF, PIS/NIS, CTPS, endereço, conta,
senha, token, certificado ou dado médico identificável. Use rótulos como
`Pessoa A` e `Empresa X`. Informe, quando souber:

- rotina e resultado esperado;
- competência e datas relevantes;
- tipo de contrato, jornada e categoria;
- sindicato e CCT/ACT aplicável;
- sistema utilizado e evidências higienizadas;
- ação que será apenas preparada ou que poderá exigir aprovação posterior.

Exemplo:

```text
Use $ac-dp com /folha-beneficios. Preciso reconciliar a folha de agosto da
Empresa X. Tenho o ponto e a prévia do sistema, mas faltam afastamentos,
benefícios variáveis e a CCT autenticada. Entregue a matriz de conferência.
```

## Escolher uma saída

- `/triagem`: classifica o caso e mostra o próximo passo;
- `/admissao`: cria matriz de cadastro, documentos, ASO, CCT e evento provável;
- `/folha-beneficios`: reconcilia ponto, eventos, benefícios e obrigações;
- `/ferias-afastamento`: separa férias, atestado, INSS, maternidade e SST;
- `/rescisao`: prepara checklist e simulação não final;
- `/esocial-sst`: organiza evento provável, documentos, fonte e responsável;
- `/pro-labore`: organiza DP e prepara handoffs Fiscal e Contábil;
- `/handoff`: transfere contexto mínimo para Fiscal, Contábil, Onboarding ou
  gestão sem alegar que o destino já atuou;
- `/mensagem`: produz rascunho sem enviar.

Os contratos completos estão em `references/dp-outputs.md`.

## Entender fonte e CCT/ACT

O Knowledge ajuda a estruturar o caso, mas não comprova regra atual. Para
legislação, tabela, layout, evento ou prazo, a skill precisa da fonte oficial
vigente. Para uma conclusão trabalhista, precisa também da CCT/ACT autenticada,
vigente e aplicável à categoria, território e período. Se isso não puder ser
confirmado, ela registra `LACUNA DE FONTE OFICIAL` e bloqueia apenas a conclusão,
continuando com checklist e coleta de evidências.

## Entender simulação e aprovação

Qualquer número parcial aparece como `SIMULAÇÃO — NÃO É FOLHA FINAL` ou
`SIMULAÇÃO — NÃO É RESCISÃO FINAL`, com dados usados e itens ausentes.

Criar checklist, matriz, simulação, handoff ou rascunho é preparação. Alterar
sistema, fechar folha, transmitir eSocial, emitir ou pagar guia, consultar com
credencial e enviar documento ou mensagem são ações externas. Cada ação exata
exige aprovação humana imediatamente antes, com sistema/canal, alvo,
evento/obrigação, competência/data e conteúdo/valores definidos. Até existir
execução e recibo real, o estado permanece `NÃO EXECUTADO`.

## Instalação seletiva da release

O checkout inteiro não é a pasta instalável. `agent.yaml`, em
`skill_runtime.package`, é a allowlist normativa. Uma instalação copia
exatamente 29 arquivos regulares:

- `SKILL.md`, `agent.yaml` e `agents/openai.yaml`;
- as três políticas em `references/`;
- dois arquivos de identidade, três de objetivos e dois de instruções;
- os 16 anexos listados em `skill_runtime.knowledge`.

Não copie `.git`, `.github`, avaliações, governança, relatórios, scripts,
testes, documentação, `.gitkeep` ou arquivos fora da allowlist. Preserve nomes,
caminhos e bytes. A instalação final deve registrar inventário, SHA-256 agregado,
29/29 arquivos iguais, 16 Knowledge, zero symlinks e zero `.gitkeep`.

A versão `0.2.0` está `validated`. P1–P5 literais qualificaram; P6 literal foi
suprimido pela plataforma antes da resposta e permanece sem PASS, FAIL ou nota.
O cenário substituto de P6 passou como evidência semântica adicional, não como
substituição do teste literal. Uma futura mudança de plataforma deve tentar o
P6 literal novamente.

## Manter funcionando

Antes de promover uma alteração, execute:

```bash
bash tests/validate-agent-repo.test.sh
bash tests/validate-dp-skill.test.sh
bash scripts/validate-agent-repo.sh
ruby scripts/validate-dp-skill.rb
git diff --check
```

Depois, rode P1–P6 em contextos independentes para a skill, preserve os textos
brutos e hashes, pontue pela mesma rubrica do GPT e valide a instalação byte a
byte. Se a plataforma suprimir um caso antes da resposta, registre a supressão
como `NOT_SCORED`, nunca como PASS ou FAIL; um surrogate pode complementar a
evidência, mas não conta como execução literal. Mudança de instrução, Knowledge,
política ou comportamento requer nova avaliação e nova versão.

Se o GPT ou os anexos mudarem, faça nova captura somente leitura, preserve-a em
separado e compare antes de promover. Nunca altere o GPT para forçar paridade.
