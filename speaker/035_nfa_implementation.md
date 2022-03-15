### Implementation of NFAs

The similarity of how the Unix fork system call and how NFAs spawn new computations is scary.
You might be tempted to think one guy might have a hand in both algorithms.

It should be stated, that there is a formal proof that for regular languages, any NFA can be manually converted into an equivalent DFA.
Thus, any NFA that accepts some language L, there is a equiv DFA that accepts the exact same language
The first step in this manual rewriting   requires Thompson's construction.
