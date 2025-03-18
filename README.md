# First-Bullet-Hell
A bullet hell game i'm developping, this time with a custom version of godot 3.5 so that it can be exported to a quite niche console, which one? try to guess, i'll give some hints in the README.md when i make some changes to it.
# Latest changes
### This repository is now public!
The developper (and only person working on the project so far) no longer sounds like he hears voices that don't exist.
## Health system
Added a health system along with a special hitbox that checks for RigidBody2D nodes, and if it detects one, it removes 10 health (will add a way to make it change based on a property of the RigidBody2D), starts a cooldown, and adds the RigidBody2D's ID to a "attacks_entered" array. If the attack leaves the hitbox at any point in time, then it gets removed from that array, but if it doesn't before the cooldown ends then the player takes damage again. Will add a death system in the future.
## Bug fix(es)
Fixed a bug where the "mid_air" animation would play even if the player was on the ground due to a rounding error on certain platforms
## Debug feature(s)
Added a text that floats above the player indicating its x and y velocities respectively (which allowed me to find out about the aforementionned rounding error, as it displayed -0.000004 on the vertical velocity).
Added a health counter to test the functionnality of damage sources.
