# Contexto de gamedev com Godot — Ricardo

## Quem é
Dev Java fullstack (Java 17/sdkman, IntelliJ). **Responda sempre em pt-BR.**
Ao explicar conceito novo de Godot, ancore em Java/Spring/OO — é o que fixa.

## Ambiente
- Godot **4.7.2** em `~/Aplicativos/godot/godot`. Sem C#, só GDScript.
- Plugin **Godot AI** dá acesso MCP ao editor ao vivo. Escopo `local`.
- A sessão do Claude precisa **começar dentro da pasta do projeto**, e o projeto
  precisa ter sido aberto no Godot uma vez, senão os tools MCP não aparecem.

## Modo de trabalho: tutor
Ele executa as ações no editor; eu explico o passo e depois **valido lendo os
`.tscn`/`.gd`** antes de seguir. Um passo por vez.
- Ler o `.tscn` como texto é a checagem mais rápida: mostra o que o editor
  gravou de fato, inclusive os defaults que ele omite.
- Ele faz bem o trabalho de Inspector/Scene dock, mas **pula edição de script**
  quando ela vem no meio de um passo grande. Dar bloco próprio e oferecer
  aplicar pelo terminal.
- Erro comum e silencioso: salvar o script e esquecer de salvar a **cena**.

## Convenções obrigatórias — desde a primeira linha, sem refatorar depois
1. **Tipagem estática em tudo.** `var score: int = 0`,
   `func start(pos: Vector2) -> void:`. E `class_name` nos scripts que outros
   scripts referenciam — dá autocomplete e erro em tempo de parse.
2. **Nada de `$Node` por string repetido.** `@onready var hud: HUD = $HUD`
   resolvido uma vez, e `%UniqueName` (nó marcado *Access as Unique Name*) para
   nós fundos na árvore, para que mover/renomear não quebre em runtime.
3. **Estado que atravessa troca de cena vai em autoload**, um por
   responsabilidade (`GameState`, `Audio`) — nunca um balaio global.
4. Persistência em `user://` (`res://` é somente leitura no build exportado).

## Assets
Preferir **Kenney** (CC0, estilo consistente). Escolher o pack **antes** de
definir o jogo — ideia primeiro leva a "preciso de um sprite que não existe".

## Onde escrever o que for surgindo
Quando aparecer algo que vale registrar, decida o arquivo antes de escrever:

- **Este arquivo (pai)** — vale para *qualquer* projeto Godot dele: convenção de
  código, ambiente/ferramenta, forma de trabalhar, preferência pessoal.
- **`CLAUDE.md` do projeto (filho)** — só o que é verdade *naquele jogo*: escopo,
  assets usados, decisões de design, pegadinhas daquele projeto.

Regras:
- **Na dúvida, filho.** Promover para o pai depois é barato; regra errada no pai
  contamina todo projeto novo e é difícil de perceber.
- Antes de escrever, procure linha equivalente e **atualize em vez de duplicar**.
- Os dois são arquivos de instrução: curtos, no imperativo, sem histórico nem
  changelog. O que aconteceu fica no git e no código.
- **Toda alteração no pai deve ser avisada explicitamente a ele**, porque muda o
  comportamento nos projetos futuros. No filho, pode escrever e mencionar.

## Estrutura e nomenclatura
- Pasta por feature, cena e script juntos (`player/player.tscn` + `player.gd`).
  Nunca `scenes/` e `scripts/` separados. **Mover sempre pelo FileSystem dock**
  do Godot — mover pelo terminal quebra as referências.
- Arquivo `snake_case`; nó e `class_name` em `PascalCase`; const em
  `MAIÚSCULA_SNAKE`; membro privado com `_` na frente.
- `class_name` só quando outro script referencia o tipo.
- Nome de grupo, animação e ação vira `const NOME := &"valor"` (StringName),
  nunca string literal repetida no código.
- Valor de tuning (velocidade, ângulo, tempo) vai em `@export`, para ajuste no
  Inspector com o jogo rodando — não chumbado no código.
- Ordem dos membros: class_name, extends, signals, enums, consts, @export,
  vars, @onready, _ready/_process, métodos públicos, métodos privados.

## Testes
- Sem framework embutido; usar **gdUnit4**. Testar **lógica pura**, não nó,
  física ou animação.
- Para isso, regra de jogo em classes puras (`RefCounted`/`Resource`), fora dos
  nós — domínio separado do "controller", como no backend Java.
- `git init` no primeiro dia de qualquer projeto novo.
