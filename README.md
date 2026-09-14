# Workspace de gamedev com Godot

Documentos compartilhados entre meus projetos Godot. Cada jogo vive em um
repositório próprio; esta pasta só guarda o que vale para todos eles.

## Conteúdo

- **`godot-claude.md`** — contexto e convenções que valem para qualquer projeto
  Godot meu: ambiente, forma de trabalhar, padrão de código, estrutura de
  pastas, nomenclatura e testes. Cada projeto tem um `CLAUDE.md` de uma linha
  importando este arquivo (`@../godot-claude.md`), então a regra vive em um
  lugar só e não divergo entre cópias.

## Projetos

| Jogo | Estado |
|---|---|
| `dodge-the-creeps` | Concluído — tutorial oficial 2D, refatorado |

## Convenções, em resumo

Tipagem estática e `class_name`; `@onready`/`%UniqueName` no lugar de caminhos
por string; estado que atravessa cena em autoload; valores de tuning em
`@export`; pasta por feature com cena e script juntos; `git init` no primeiro
dia; gdUnit4 quando houver lógica pura que valha testar.
