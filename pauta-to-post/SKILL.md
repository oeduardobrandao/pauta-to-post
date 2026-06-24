---
name: pauta-to-post
description: >-
  Cria conteúdo de Instagram (carrossel, roteiro de reels ou post estático) para um
  cliente da DK Marketing Médico, a partir de UM dos 4 pilares da Estratégia de Conteúdo
  do cliente + um assunto relevante (competência técnica, história de vida, pauta quente,
  caso de paciente). Use SEMPRE que o usuário pedir para "criar/montar um carrossel",
  "roteiro de reels", "post estático", "um post/uma pauta para [cliente]", ou mencionar
  criar conteúdo/post + cliente juntos, mesmo sem dizer "skill" e sem citar o pilar.
  Também adapta um post existente quando o usuário manda um LINK ou prints de um post do
  Instagram e pede "refazer/adaptar/fazer uma versão para [cliente]" (mantém
  estrutura/trend/ideia e troca voz e estilo); veja references/adaptar-link.md. Puxa do
  Mesaas a estratégia, o briefing e os posts que melhor performaram do cliente como
  referência, e escreve no formato exato da casa, pronto pra colar.
---

# Pauta → Post

Esta skill transforma um pilar da estratégia + um assunto em um **post pronto** no formato
da DK Marketing Médico. O valor está em três coisas: (1) ancorar o post nos pilares e no
tom de voz REAIS do cliente, (2) imitar o que **já performou** no perfil dele (não um
padrão genérico de Instagram), e (3) entregar no formato exato que a casa usa, com a
assinatura certa — pronto pra colar no Mesaas.

Não há ferramenta de escrita no Mesaas: a skill **gera os arquivos/texto**, ela não grava
de volta. Avise o usuário que ele cola o resultado lá.

## Princípio-guia: torne o cliente uma necessidade

Acima de qualquer regra de formato, cada post existe para resolver um **medo** ou uma
**necessidade real** de quem segue o cliente. O público de um pediatra, por exemplo, segue
por medo (de errar, de não perceber um sintoma, de confundir uma coisa com outra) e por
necessidade prática (telas, alimentação, sono, desenvolvimento). Regras de algoritmo mudam o
tempo todo; o que não muda é isto: um perfil cresce quando se torna indispensável. Isso guia
três decisões em todo post:

- **Pauta:** escolha temas que respondam a um medo ou necessidade concreta do público, não o
  que está "em alta". Para cada pauta, pergunte: que medo ou necessidade real isto resolve?
  Sem resposta clara, é pauta fraca.
- **Profundidade:** o conteúdo precisa ser bom a ponto de alguém que ia fechar o app desistir
  por causa dele. Entregue utilidade de verdade, não enrolação nem truque de formato.
- **Relação, não ponto final:** feche o post como início de uma parceria longa, não como
  assunto encerrado. Convide a voltar, a salvar pra usar depois, a procurar o cliente quando
  precisar. A pessoa deve sair sentindo que ali tem alguém com quem pode contar.

A consistência de voz e posicionamento (que a skill garante ao espelhar os campeões) reforça
isso: faz o público reconhecer o cliente sem precisar de apresentação.

## Fluxo de trabalho

1. **Resolver o cliente.** `list_clients` → nome → `client_id`, especialidade, cor.
2. **Carregar a estratégia.** `list_pages(client_id)` → achar a página "Estratégia de
   Conteúdo" e extrair os **4 pilares** (nome + exemplos de título), o **tom de voz** e o
   **O QUE NÃO FAZER**. Se não existir estratégia, avise e ofereça rodar a skill
   `briefing-to-content-strategy` antes (sem ela, o post fica sem âncora).
3. **Carregar voz + assinatura.** `get_brand_profile(client_id)` traz o briefing (história
   de vida, palavras-chave, emojis, "evitar"). A **assinatura** (nome + conselho + RQE) não
   está no briefing — pegue-a de um post recente: veja "Assinatura" abaixo.
4. **Puxar os campeões do formato.** `list_posts(client_id, formato=<fmt>, sort_by_metric=
   <metrica>, limit=5)` e depois `get_post` em 2-3 deles para ler o `conteudo_plain` e usar
   como referência de ESTILO (estrutura, ritmo, tipo de gancho, CTA, comprimento). Métrica
   por formato — veja "Quais campeões puxar".
5. **Propor 2-3 pautas e deixar o usuário escolher.** Cada pauta = **1 pilar + 1 assunto**,
   com título concreto. Veja "Como propor pautas". Não escreva o post ainda — apresente as
   opções e espere a escolha. (Se o usuário já deu pilar + tema explícitos, pode pular a
   proposta e confirmar rapidamente o ângulo.)
6. **Escrever no formato da casa.** Confirme o formato (carrossel / reels / estático). Leia
   a referência do formato (`references/carrossel.md`, `references/reels.md`,
   `references/estatico.md`) ANTES de escrever e siga o esqueleto exato.
7. **Entregar.** Sempre gere o **texto pronto** (espelhando `conteudo_plain` + legenda) em
   Markdown. Depois **pergunte se o usuário quer os slides renderizados na marca** — se sim,
   veja "Slides renderizados". Salve em `/mnt/user-data/outputs/` e use `present_files`.

## Resolver o cliente e a estratégia

- O usuário costuma citar o cliente por nome ("um carrossel pra Crícia"). Resolva via
  `list_clients`; se houver ambiguidade (dois nomes parecidos), pergunte qual.
- A página de estratégia é a fonte canônica dos pilares. Os exemplos de título dentro de
  cada pilar são ouro: indicam o tom e o tipo de gancho que o cliente aprovou.
- Respeite o **O QUE NÃO FAZER** da estratégia como trava dura (ex.: nada de política,
  charlatanismo, promessa milagrosa, jargão sem explicação).

## Assinatura (obrigatória, tirada dos posts reais)

Toda legenda termina com o bloco de assinatura do cliente, que **já está nos posts**. Pegue
o exato: chame `list_posts(client_id, limit=3)` em posts publicados e copie o rodapé do
`ig_caption` (ex.: `Crícia Pontes` / `CREMEC 18231 | RQE 18289`). Nunca invente número de
conselho ou RQE — se não encontrar em nenhum post, pergunte ao usuário.

## Quais campeões puxar (por formato)

Use o `sort_by_metric` que reflete o objetivo do formato. Confirme com
`get_performance_baseline(client_id)` qual formato/métrica de fato performa melhor naquele
perfil e ajuste:

- **Carrossel** → `sort_by_metric=saved` (e olhe `comments`). Carrossel vive de salvamento.
- **Reels** → `sort_by_metric=shares` (e `reach`). Reel vive de compartilhamento e alcance.
- **Estático** → `sort_by_metric=reach`. É o formato mais fraco — use com parcimônia.

Leia 2-3 campeões e extraia o **padrão**, não o conteúdo: quantas telas/cenas, tamanho das
frases, como abre o gancho, que tipo de CTA fecha, onde entra história pessoal. O post novo
deve "soar" como esses, sobre o tema novo.

## Aprenda com o workspace inteiro, sempre

Esta skill vive acoplada ao Mesaas, então aproveite isso a cada uso. Além dos campeões do
próprio cliente, puxe os posts de MAIOR PERFORMANCE e os MAIS RECENTES de TODOS os clientes
(`list_posts` SEM `client_id`, ordenado por `reach` e por `shares`; e use `published_since`
para ver o que saiu recentemente). Leia o `conteudo_plain` e a `ig_caption` dos melhores e
extraia os PADRÕES que se repetem entre nichos:

- **Ganchos que dão alcance:** cena relatável + "antes de fazer X, vê isso"; quebra de mito
  com alívio ("você acha que precisa, mas não"); newsjacking de pauta quente (data, evento,
  nota de sociedade médica); confissão emocional que valida o público.
- **Ritmo:** com que rapidez abrem o ciclo de curiosidade e entregam o payoff.
- **CTA que vira necessidade:** "salva pra consultar sempre que a ansiedade bater", convites
  que abrem relação em vez de encerrar o assunto.
- **Legenda:** uso de estatística/fonte para autoridade, frases curtas, assinatura.

**Use o padrão, NUNCA o conteúdo.** Jamais transplante a história pessoal, as alegações ou
os fatos de especialidade de um cliente para outro (a história de um, o número de conselho
de outro, a nota técnica de um terceiro). O padrão é a forma; a substância, a voz e a
assinatura vêm sempre do cliente-alvo e dos dados dele. Cada execução é uma chance de
aprender o que está funcionando agora e melhorar a copy — registre o que viu e aplique.

## Como propor pautas (o passo que define a qualidade)

Gere 2-3 pautas, cada uma cruzando **um pilar** com **um tipo de assunto**. Varie os tipos
entre as opções. Os tipos de assunto:

- **Competência técnica** — explicar/desmistificar uma condição da especialidade (sai das
  "condições" da estratégia e do conhecimento clínico).
- **História de vida** — um fato pessoal do briefing (a matéria-prima do pilar de
  humanização). Ex. Crícia: APLV dos filhos, prematuridade da Melina, UTI, amamentação.
- **Pauta quente / sazonal** — algo do momento. Use `web_search` para checar o que é
  estação/tendência agora (ex.: em junho no Brasil é inverno → vírus respiratórios,
  bronquiolite/VSR; campanhas de vacinação; volta às aulas). Confirme datas reais.
- **Caso de paciente (arquetípico)** — uma situação comum de consultório, sempre
  fictícia/anonimizada, nunca um paciente real identificável.

Apresente assim (uma linha por pauta), e peça pro usuário escolher:

```
1. [Pilar: Educação em saúde · Competência técnica] "Febre não é a doença — é o exército do corpo trabalhando"
2. [Pilar: Mãe e médica · História de vida] "Interrompi a amamentação da minha filha aos 4 meses. E tudo bem."
3. [Pilar: Educação em saúde · Pauta quente] "Chiado no peito no inverno: quando correr pro pronto-socorro"
```

Títulos CONCRETOS, no tom do cliente — nunca temas vagos ("falar sobre febre"). Se o usuário
já trouxe o tema, ofereça 2-3 ângulos/títulos para ESSE tema em vez de temas diferentes.
Teste toda pauta contra o princípio-guia: que medo ou necessidade real ela resolve? Se a
resposta for fraca, troque a pauta.

## Escrever o post

Leia a referência do formato escolhido antes de escrever. Regras transversais a todos:

- **Vá direto ao conteúdo; aprofundamento vai pro fim.** Corte introduções longas: logo
  depois da capa, a primeira tela/cena já entrega o que a pessoa veio buscar. Embasamento,
  dados de contexto e explicações que dão profundidade ficam para o FINAL do post, não para
  a abertura. Assim quem está com pressa encontra a resposta cedo, e quem quer se aprofundar
  continua até o fim.
- **Tom espelha o cliente — extraído dos campeões, não inventado.** Antes de escrever,
  releia o `conteudo_plain` dos posts que você puxou e anote os MARCADORES concretos de voz:
  perguntas retóricas ("Sabe aquela…?"), interjeições ("pois é", "viu?"), pessoa ("te
  mostro", "nós, mães"), tamanho e ritmo de frase, emojis. Reproduza esses marcadores. Frase
  conversada, "de quem senta do lado", não "de quem palestra". Se o cliente escreve fluido,
  NÃO transforme em listão de comando ("Corra se:", "Sinais de alerta:") — isso é voz de
  influencer-médico genérico, não a dele.
- **Evidência, sem charlatanismo.** Nada de promessa, cura milagrosa ou afirmação sem base.
- **Conteúdo de saúde com gradiente claro.** Ao ensinar sinais de alerta, preserve a escada
  de gravidade: o que dá pra observar em casa, o que pede avaliação médica logo, e o que é
  emergência imediata. Não colapse tudo em "corra pro pronto-socorro" — além de impreciso,
  vira alarmismo, que a estratégia manda evitar.
- **História pessoal só quando pedida.** NÃO encaixe relatos pessoais do briefing por
  padrão. Use o relato real apenas quando o usuário pedir explicitamente OU quando a pauta
  escolhida for do tipo "história de vida". Nos demais casos, mantenha o post focado no
  conteúdo, sem expor a vida da pessoa.
- **Evite os "sotaques de IA" na escrita.** Três muletas denunciam texto de IA e devem ser
  evitadas: (1) **travessão** (—) — troque por vírgula, parênteses, ponto, ou reescreva a
  frase; (2) **frases muito curtas empilhadas** em sequência (ritmo staccato) — varie o
  comprimento e deixe a prosa fluir como fala natural; (3) **antítese fácil** do tipo "não
  é isso, é aquilo" / "não X, mas Y" usada como muleta — use no máximo uma vez no post, e
  só se for um recurso real do cliente (por ex. numa capa que ele já usa assim). Atenção:
  essa restrição vale para o CORPO do texto. No GANCHO (capa de carrossel ou CENA 1 de
  reels) a antítese "não é X, e sim Y…" é liberada e até recomendada como isca de
  curiosidade, porque ali ela abre um ciclo que prende a atenção.
- **CTA sempre fecha.** Comentar uma palavra-chave, salvar, "manda pra uma mãe que…",
  agendar. Escolha o CTA pelo objetivo (alcance → compartilhar; autoridade → salvar; venda →
  WhatsApp/agendar). Sempre que der, o fecho abre relação (voltar, salvar pra usar depois,
  procurar o cliente), em vez de encerrar o assunto.
- **Direção de arte entre colchetes.** Onde uma foto/ take ajuda, escreva a instrução em
  `[colchetes]`, como nos posts reais (ex.: `[foto da dra. com os filhos]`).
- **Assinatura na legenda.** Sempre feche a legenda com o bloco de assinatura exato.

## Slides renderizados (opcional, quando o usuário pedir)

Para **carrossel** e **estático**, ofereça gerar os slides na identidade da marca:
- Leia `/mnt/skills/public/pptx/SKILL.md` antes de criar o arquivo.
- Paleta/tipografia: puxe de `hub_brand` (get_brand_profile). Se vier vazio, reuse a paleta
  da Estratégia de Conteúdo do cliente; em último caso, base candy clean (e avise que é
  provisória). Respeite cores que o cliente pede para evitar.
- Um slide por TELA; capa com o gancho grande; última tela = CTA. Proporção 4:5 (1080x1350)
  ou 1:1 para estático.
Para **reels** não há slide — em vez disso, ofereça um **storyboard/shotlist** (tabela CENA →
take → fala) ou só o roteiro. Não force slides em reels.

## Saída e nomes de arquivo

- Texto: `/mnt/user-data/outputs/<Cliente>_<Formato>_<slug-do-tema>.md` — espelhando o
  `conteudo_plain` (CAPA/TELAS ou DURAÇÃO/CENAS) + a legenda com assinatura, pronto pra colar.
- Slides (se gerados): `.pptx` (ou imagens) com o mesmo nome.
- Apresente com `present_files` e um resumo curto (pilar, assunto, CTA escolhido).

## Princípios de qualidade

- **Imite o que performou, não o Instagram genérico.** O diferencial é soar como os
  campeões DAQUELE cliente.
- **Concreto vence vago.** Título e cada tela dizem algo específico e acionável.
- **Coerência com a marca.** Vocabulário obrigatório (ex.: "paciente" se a marca exige),
  valores, estética e o "o que não fazer" da estratégia.
- **Uma pauta, um recorte.** Não tente cobrir a condição inteira num post; escolha um ângulo.

## Arquivos de referência

- `references/carrossel.md` — esqueleto exato do carrossel + CTA bank + exemplo. Leia antes
  de escrever carrossel.
- `references/reels.md` — esqueleto do roteiro de reels + storyboard + exemplo.
- `references/estatico.md` — esqueleto do post estático/feed + exemplo.
- `references/adaptar-link.md` — sub-skill para refazer um post existente (a partir de link
  OU prints das telas) na cara de um cliente, mantendo estrutura/trend/ideia. Leia quando o
  usuário mandar um link ou screenshots e pedir uma adaptação/versão.
