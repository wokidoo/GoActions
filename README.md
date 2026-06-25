# GoActions

GoActions is a Godot editor addon for building reusable, visual action flows without writing new scripts for every trigger or behavior. It exposes a small set of `GoAction` node types that can call methods, sequence actions, delay execution, tween properties, destroy nodes, and emit debug messages — all through exported properties and scene composition.

## Purpose

GoActions aims to make node behavior easier to assemble and reuse by separating *action definition* from *scripted logic*.

Key ideas:
- Use a reusable `GoAction` base class as a generic trigger node.
- Compose action graphs in the scene tree instead of hard-coding callbacks.
- Trigger behavior in other nodes without subclassing or writing new custom scripts.
- Support sequential and parallel execution patterns with built-in nodes.

This follows the spirit of common design patterns like:
- Command pattern: each `GoAction` encapsulates a triggerable operation.
- Chain/sequence pattern: action nodes can be arranged in ordered workflows.
- Composition over inheritance: combine ready-made actions without custom script logic.

## Features

- `GoActionCaller`
  - Call any method on a target node.
  - Pass parameters to the target method.
- `GoActionSequence`
  - Trigger child `GoAction` nodes one after another.
  - Wait for each child to finish before the next starts.
- `GoActionParallelSequence`
  - Trigger child `GoAction` nodes simultaneously.
  - Wait until all children complete.
- `GoActionDelay`
  - Pause execution for a configurable duration.
  - Useful between actions in a sequence.
- `GoActionTween`
  - Tween a target node property over time.
  - Supports transition/ease types and optional value restore.
- `GoActionDestroy`
  - Queue-free a target node when triggered.
- `GoActionDebug`
  - Print a timestamped debug warning when triggered.
  - Useful for verifying action flow while editing.

## How it works

`GoAction` is the abstract base node:
- It exposes a `trigger()` method.
- It emits `started()` and `finished()` signals.
- Custom actions implement `_trigger()` to define their behavior.

This enables:
- Editor-driven workflows
- Non-script wiring of behavior
- Reuse across scenes
- Simple visual orchestration of events

## Installation

1. Place the goactions folder in your project.
2. Open Project → Project Settings → Plugins.
3. Enable `GoActions`.

## Usage

### Basic method-calling example

Add a `GoActionCaller` node, then configure:
- `target_node` → the node that owns the method
- `method_name` → the method to call
- `parameters` → parameters for the call

Then call `trigger()` or use the editor tool button to test.

### Sequence example

Use `GoActionSequence` with child action nodes:

- `GoActionCaller` to call one method
- `GoActionDelay` to pause
- another `GoActionCaller`

This creates a simple workflow:
1. invoke method A
2. wait
3. invoke method B

### Parallel example

Use `GoActionParallelSequence` with multiple child actions to run them at once and finish only when all are complete.

### Tween example

Use `GoActionTween` to animate a property:
- `target_node`
- `property_path`
- `final_value`
- `duration`
- `trans` / `ease`

### Destroy example

Use `GoActionDestroy` to remove a node from the scene when the action triggers.

### Debug example

Add `GoActionDebug` to a flow to print a message and confirm the sequence is running as expected.

## Example Scene Setup

```gdscript
# Example conceptual setup:
Root
 ├─ GoActionSequence
 │    ├─ GoActionCaller (call "start" on Player)
 │    ├─ GoActionDelay (duration = 0.5)
 │    ├─ GoActionTween (tween Player.position to Vector2(200, 100))
 │    └─ GoActionDebug (message = "Player move complete")
 └─ GoActionDestroy (target_node = OldEnemy)
```

This lets you build event-driven logic visually using nodes instead of writing new scripts for each interaction.

## Why use GoActions?

- Reduce boilerplate code for simple node triggers
- Keep scenes declarative and easier to inspect
- Avoid creating one-off scripts for transient interactions
- Make workflows easier to reuse and maintain

## Notes

- `GoAction` itself does nothing until a subclass implements `_trigger()`.
- `GoActionSequence` and `GoActionParallelSequence` are ideal for composing complex flows.
- The plugin is designed for editor-friendly behavior wiring and rapid prototyping.

---

GoActions is especially useful when you want to trigger behavior across nodes without creating separate custom scripts for every case. It makes action orchestration feel more like building a flowchart of node interactions than writing event code.