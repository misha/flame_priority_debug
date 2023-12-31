# Priority Debug

This project contains a situation in which component priority does not behave as expected.

# Setup

There are four elements:

  - The player, a green circle.
  - The enemy, a red circle.
  - The enemy's corpse, a purple circle, that appears when the enemy dies.
  - And the "mote", a small orange dot, that appears then vanishes.

Priority is dictated by the index of the `Priority` enum value:

```dart
enum Priority {
  corpse,
  enemy,
  player,
  mote,
}
```

# Scenarios

The app comes with two buttons for the two scenarios, `Delete Mote First` and `Leave Corpse First`.

## Delete Mote First

![Delete Mote First](docs/mote_first.gif)

In this scenario, the mote and enemy both appear. The enemy is scheduled to die in one second. Before this can happen, the mote disappears.

When the enemy dies, it leaves a `Corpse`. For some reason, the `Corpse` is drawn on top of the `Player`, despite its priority being lower.

## Leave Corpse First

![Leave Corpse First](docs/corpse_first.gif)

In this scenario, the enemy is also scheduled to die in one second. After doing so, it leaves a corpse. Shortly afterwards, the mote vanishes as well.

The `Corpse` is correctly drawn under the `Player` in this scenario.

# Expected Behavior

I expected that the corpse be painted under the player in both situations, but in this example, the mote disappearing first causes the corpse to now paint on top of the player instead.

Any ideas?

# Changelog

- Spydon noticed the game wasn't destroying its camera correctly when reset, which may cause a situation with multiple cameras. I changed the `PriorityDebugGame` to execute exactly once, rather than recycle anything, to ensure a clean slate for every run. The `App` became a `StatefulWidget` to support creating a brand new game every time a button is pressed.
