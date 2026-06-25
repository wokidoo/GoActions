![GoActions](addons/goactions/icons/go_action_sequence.svg)
---
# GoActions

A small Godot addon for wiring node behavior visually, without creating a new script for every event.

GoActions provides a set of reusable action nodes that can trigger methods, sequence events, delay execution, tween properties, and destroy nodes, all using exported properties and scene composition.

---

## 🤔 Why use GoActions?

If you find yourself creating lots of one-off scripts to trigger other nodes, this addon helps move that logic into the scene tree.

It is especially useful when you want:

- editor-driven gameplay flows
- node interactions without extra script files
- reusable action graphs across scenes
- simple command-style behavior composition

GoActions is inspired by common patterns like the command pattern and sequence/composite workflows.

---

## ✨ What it includes

- `GoActionCaller`
  - call any method on a target node
  - pass parameters from the inspector
- `GoActionSequence`
  - execute child actions one by one
  - wait for each child to finish before continuing
- `GoActionParallelSequence`
  - run child actions in parallel
  - complete only when every child finishes
- `GoActionDelay`
  - pause a flow for a fixed duration
- `GoActionTween`
  - tween a target node property over time
  - supports transition/ease settings and optional restore
- `GoActionDestroy`
  - call `queue_free()` on a node when triggered
- `GoActionDebug`
  - print a timestamped debug warning during execution

---

## 🧠 How it works

`GoAction` is the abstract base type. It exposes a `trigger()` method and uses signals:

- `started()` when execution begins
- `finished()` when execution completes

Concrete action nodes implement `_trigger()` to define their behavior. This lets you treat actions like reusable commands that can be composed in the scene tree.

---

## ⚙️ Installation

1. Copy the `addons/goactions` folder into your Godot project.
2. Open `Project > Project Settings > Plugins`.
3. Enable `GoActions`.

---

## 🚀 Getting started

### Basic action caller

1. Add a `GoActionCaller` node.
2. Set `target_node` to the node you want to control.
3. Set `method_name` to the function you want to call.
4. Add any required `parameters`.

Then call `trigger()` from code or connect it inside a larger action flow.

### Build a sequence

Use `GoActionSequence` and add child actions in order:

- `GoActionCaller`
- `GoActionDelay`
- `GoActionCaller`

This creates a timeline like:

1. method A runs
2. pause
3. method B runs

### Run actions in parallel

Use `GoActionParallelSequence` to start multiple actions at once and wait until they all complete.

---

## 🧩 Example

```text
Root
 ├─ GoActionSequence
 │    ├─ GoActionCaller (target_node = Player, method_name = "start")
 │    ├─ GoActionDelay (duration = 0.5)
 │    ├─ GoActionTween (target_node = Player, property_path = "position", final_value = Vector2(200, 100))
 │    └─ GoActionDebug (message = "Player move complete")
 └─ GoActionDestroy (target_node = OldEnemy)
```

This setup is ideal for prototyping and iterating without adding specialized script logic to every node.

---

## 💡 Use cases

- trigger animations from the editor
- sequence UI events without custom scripts
- delay gameplay actions for timing
- tween object properties from the inspector
- destroy temporary nodes after an event
- add debug output to verify action order

---

## 📌 Notes

- `GoAction` does nothing by itself until a subclass implements `_trigger()`.
- `GoActionSequence` and `GoActionParallelSequence` are designed for composing reusable flows.
- This addon is best when you want behavior configured in scenes rather than in many custom scripts.
- This project was inspired by the following [presentation](https://youtu.be/hOh7w-RZRSI?si=kn4yrVluKo5akVds) by **ROKOJORI** at GodotCon 2026. Credit to them for the inspiration :)
---

## 🤝 Contributing

If you want to add new action types, improve documentation, or suggest enhancements, please open an issue. Feedback is welcome and appreciated!