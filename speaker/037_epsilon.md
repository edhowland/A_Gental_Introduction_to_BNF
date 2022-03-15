### The Epsilon symbol
### Implications of the existence  of Epsilon for the the delta LUT
### The Epsilon symbol

Although it appears as a column in the delta lookup table, epsilon is actually 
not a terminal symbol from the input.  If the state row (from Q) has an entry
in the Epsilon column, it will always take that branch. IOW: A spawned FSM
will be launched along the new  state path.

### Implications of the existence  of Epsilon for the the delta LUT

- Blank entries must therefore exist for states without matching Epsilon columns
- Epsilon moves are always taken. If a state is entered, the next state immediately becomes the current state
  * But only the newly spawned child FSM.
