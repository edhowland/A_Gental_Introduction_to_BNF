### The Stack

For CFL's,  there is always a stack involved.
It may be a call stack in the case of a Recursive Descent Parser, but probably a data stack in predictive LL(K) or any LR(K) parser.
Shift/reduce parsers, like those produced via yacc, usually have 2 stacks or a single stack that holds 2 values
1. The current state : Which states happened to get us to this point
2 A data stack where we push Terminals, pop many of them and then push back the matching nonterminal
The push action in the latter case is called: shift
The pop many action then push nonterminal is called reduce
In fact, productions in our BNF are reversed and called reductions