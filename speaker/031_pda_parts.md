### Components of a PDA

This is just like a DFA's parts
We need to add an additional alphabet, called Gamma. It can be equiv to Sigma or entirely different.
Remember our canonical balanced parens example, the so-called Hello World of CFGs?
We could have the letter 'L' instead of '(' for Gamma, but we did not to do so
In addition, the delta function does 2 more things:

First, it takes as input, in addition to the current state and the next item of input, also the top of the stack.
Second, it not only returns the next state, but some action: Do we pop, or push, and if so, then what symbol from Gamma

We are going to handle epsilon during  the nondeterminism part of the talk.
But for right  now if we see Eps in the top of the stack or returned from some state transition, then it just means do not push or pop anything. Kind of ...
