# pauta-to-post

Skill da **DK Marketing Médico** que transforma um pilar da Estratégia de Conteúdo do cliente
+ um assunto relevante em um post de Instagram pronto: **carrossel**, **roteiro de reels** ou
**post estático**. Funciona acoplada ao **Mesaas**, de onde puxa a estratégia, o briefing e os
posts que melhor performaram para usar como referência de estilo.

## O que ela faz

- Resolve o cliente no Mesaas e carrega os **4 pilares** da estratégia, o **tom de voz** do
  briefing e o **"o que não fazer"**.
- Puxa os **posts campeões** do cliente (e do workspace inteiro) como referência de estilo.
- Propõe **2-3 pautas** (pilar + assunto: competência técnica, história de vida, pauta quente,
  caso de paciente) para o usuário escolher.
- Escreve no **formato exato da casa**, com a assinatura correta, pronto pra colar no Mesaas.
- Opcionalmente, **renderiza os slides** na identidade da marca.
- Também **adapta um post existente** (a partir de link ou de prints das telas), mantendo
  estrutura/trend/ideia e trocando voz e estilo para o cliente escolhido.

## Princípio-guia

Acima de qualquer regra de formato: cada post existe para resolver um **medo** ou uma
**necessidade real** de quem segue o cliente, a ponto de tornar o perfil indispensável. A
escolha de pauta, a profundidade e o fecho (que abre relação, não encerra o assunto) seguem
esse princípio.

## Regras de qualidade embutidas

- Voz **extraída dos campeões** do cliente, não um padrão genérico de Instagram.
- Capa/gancho com a cara do cliente; **curiosidade e open loop** (antítese liberada só no
  gancho, proibida como muleta no corpo).
- Sem "sotaques de IA": **sem travessão, sem frases curtas empilhadas, sem antítese-muleta**.
- **Direto ao conteúdo**, com o aprofundamento no fim.
- **História pessoal só quando pedida.**
- **Gradiente de gravidade** em conteúdo de saúde (observar → avaliar → emergência); sem
  alarmismo.
- **Aprendizado contínuo** com o que há de melhor e mais recente no Mesaas — usando o
  *padrão*, nunca o conteúdo de outro cliente.

## Estrutura

```
pauta-to-post/
├── SKILL.md                      # fluxo, princípio-guia e regras transversais
└── references/
    ├── carrossel.md              # esqueleto + CTA bank + exemplo
    ├── reels.md                  # esqueleto + storyboard + exemplo
    ├── estatico.md               # esqueleto + exemplo
    └── adaptar-link.md           # sub-skill: refazer post de link/prints para um cliente
dist/
└── pauta-to-post.skill           # pacote instalável
install.sh                        # instalador one-liner (curl … | bash)
examples/                         # exemplos gerados (Crícia)
```

## Requisitos

- Conector **Mesaas** ativo (clientes, estratégia, briefing, posts e performance).
- Para renderizar slides: ambiente com a skill `pptx` disponível.

## Instalação

O Claude Code procura skills em dois lugares (cada skill é uma pasta com um `SKILL.md` dentro):

| Escopo   | Caminho                                   | Vale para        |
| -------- | ----------------------------------------- | ---------------- |
| Pessoal  | `~/.claude/skills/<skill>/SKILL.md`       | Todos os projetos |
| Projeto  | `.claude/skills/<skill>/SKILL.md`         | Só aquele projeto |

O destino final precisa ser exatamente `~/.claude/skills/pauta-to-post/SKILL.md` — **sem aninhar
um nível a mais** (nada de `~/.claude/skills/pauta-to-post/pauta-to-post/SKILL.md`). Atenção: a
raiz deste repositório contém uma subpasta `pauta-to-post/` que é a skill em si, então um
`git clone` "cru" para dentro de `~/.claude/skills/pauta-to-post` cairia justamente no aninhamento
errado. Os comandos abaixo já tratam isso.

### Opção 1 — one-liner (recomendada)

```bash
curl -fsSL https://raw.githubusercontent.com/oeduardobrandao/pauta-to-post/main/install.sh | bash
```

Para instalar só no projeto atual (em `./.claude/skills`), acrescente `--project`:

```bash
curl -fsSL https://raw.githubusercontent.com/oeduardobrandao/pauta-to-post/main/install.sh | bash -s -- --project
```

O script baixa a skill do GitHub e a coloca em `~/.claude/skills/pauta-to-post/` (ou
`./.claude/skills/pauta-to-post/` com `--project`). Rodar de novo atualiza a skill.

### Opção 2 — clonar do GitHub manualmente

```bash
git clone https://github.com/oeduardobrandao/pauta-to-post.git /tmp/pauta-to-post && \
  mkdir -p ~/.claude/skills && \
  cp -R /tmp/pauta-to-post/pauta-to-post ~/.claude/skills/ && \
  rm -rf /tmp/pauta-to-post
```

### Opção 3 — extrair o pacote `dist/pauta-to-post.skill` (a partir da raiz do repo)

O `.skill` é um zip cujo nível de topo já é `pauta-to-post/`, então basta extrair direto na pasta
de skills:

```bash
mkdir -p ~/.claude/skills && unzip -o dist/pauta-to-post.skill -d ~/.claude/skills/
```

As três opções resultam em `~/.claude/skills/pauta-to-post/SKILL.md`. Para instalar só num projeto,
troque `~/.claude/skills` por `.claude/skills` na raiz do projeto. Depois é só rodar
`/pauta-to-post` no Claude Code.

## Exemplos

A pasta `examples/` traz posts gerados para a cliente Crícia (pediatria): carrossel de
bronquiolite no inverno, dois roteiros de reels (febre x dente nascendo e validação da mãe) e
um estático de lembrete de vacina.
