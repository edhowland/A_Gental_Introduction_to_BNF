### Components of a DFA

We can construct any DFA with a 5-tuple

By Q, we mean all the states E.g. S0, S1, S2 and so on.
These form the nodes or  vertices in a state diagram

Sigma, a Greek letter. Sure are a lot of them. The input alphabet. E.g. printable ASCII chars
We need to know which state to set in our state variable before we loop. Q sub 0
The delta, or change, function takes 2 inputs: the current state variable and the current input value (in Sigma) from the input.
And finally, F or the set of final states where we have accepted the imput. This is some subset or just 1 of Q.

We also need a input reader function. And a loop what knows when to exit after all the input has been consumed.
We check the current state if it is in F.
True : accept the input
False : Reject the input

This is how deterministic regexp engines work.
There is a prior step called compile where the engine constructs the delta lookup table.
Where all the real magic actually happens.
