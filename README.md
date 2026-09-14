# Dodge the Creeps

Jogo 2D do tutorial oficial [*Your first 2D game*](https://docs.godotengine.org/pt-br/4.x/getting_started/first_2d_game/)
do Godot, feito como primeiro projeto de gamedev — e depois **refatorado** para
sair do estilo didático do tutorial e adotar convenções de projeto real.

Desvie dos inimigos que entram pelas bordas. O placar sobe 1 por segundo, e o
recorde persiste entre execuções.

## Rodar

Godot **4.7** (GDScript, sem C#). Abra a pasta como projeto e pressione `F5`.

## Estrutura

Pasta por feature — cena e script de cada coisa ficam juntos:

```
main.tscn  main.gd      ponto de entrada: spawn, timers, ciclo de partida
player/                 Area2D controlado pelo teclado
mob/                    RigidBody2D movido pela física, tipo sorteado no nascimento
ui/                     HUD em CanvasLayer
autoload/game_state.gd  singleton do recorde, persiste em user://
assets/                 arte, áudio e fonte
```

## Convenções aplicadas

- Tipagem estática em tudo e `class_name` nos scripts referenciados por outros
- `@onready var x: Tipo = $Node` resolvido uma vez, e `%UniqueName` para nós
  fundos na árvore — nada de `$caminho/por/string` repetido no código
- Nome de grupo e de animação como `const ... := &"valor"` (StringName)
- Valores de tuning (velocidade, ângulo, delay) expostos com `@export`, para
  ajustar no Inspector com o jogo rodando
- Estado que atravessa troca de cena em autoload, um por responsabilidade

## Créditos

Arte e áudio do [pacote oficial de assets do tutorial](https://github.com/godotengine/godot-docs-project-starters).
Fonte **Xolonium** de Severin Meyer, sob SIL Open Font License 1.1 — licença
completa em `assets/fonts/LICENSE.txt`.
