### Nondeterministic Automata
### Additional features of a NFA
In reality, on a single threaded system, nondeterminism just means backtracking.
For any given nonterminal that has more than one alternative, the machine must back up to the previous state and choose the next state for the given input symbol.
Obviously,  this leads to higher than simple linear time complexity.


Here is where  the theory and practice break down yet again.
For RegExps, Ken Thompson created an elegant regexp compiler and engine that works with little backtracking