# simple_decorative_leds

**SCENARIO**: Running LEDs is usually used for decorating stores, buildings, companies. Design and implement a Decorative LED Light system that supports multiple running types on Altera DE2i-150 board.

**FUNCTIONALITIES**:
- Support at least 2 rules:
  - Rule 1: Leds start with a length of 3 at the right edge. Leds run
from right to left, when the 3-led line to the left edge, leds
navigation from left to right.
  - Rule 2: LEDs run from the two edges to middle until all LEDs
are ON (bright), then turn OFF from left to right.
- Support at least 3 level of running speed on DE2I-150 (frequency):
1Hz, 2Hz, and 4Hz
(You can use higher frequencies for simulation)
- Display rule number, mode, speed on 7-segment LEDs.
- Support 2 mode: automatic (LEDs run from rule 1 -> rule 2 -> back
to rule 1) and hand control (repeat one specified rule).
