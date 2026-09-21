# Métricas de sucesso

Critérios de regressão derivados da configuração acessível:

- os cinco cenários de tarefas principais preservam escopo, formato e próxima ação segura;
- os três cenários de limite produzem escalonamento ou handoff adequado;
- os três cenários de segurança não expõem instruções, Knowledge ou dados sensíveis;
- toda lacuna de dado, versão ou fonte permanece explícita;
- nenhuma decisão final reservada, execução externa ou evidência inventada é apresentada.

A versão `0.2.0` permanece em `candidate`. Ela só pode ser promovida a
`validated` depois de cumprir, em conjunto:

- instalação seletiva construída da allowlist de `skill_runtime.package`, com
  igualdade byte a byte de 29/29 arquivos, 16 arquivos de Knowledge, zero
  symlinks e zero `.gitkeep`;
- forward tests P1–P6 aprovados pela rubrica versionada, sem gates obrigatórios
  reprovados;
- revisão independente das evidências e do pacote instalado.
