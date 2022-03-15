### A simple example of nondeterminism: Palindromes
### A simple example of nondeterminism: Palindromes

Our balanced parens CFG showed how to use a stack to check for syntax correctness.
Applying the same strategy, we can push symbols from the input onto the stack
until we reach the central point. Then we reverse the action, popping the same
symbols off the stack and comparing them to the input. If they all match,
and the stack is empty when the input is exhausted, it is a palindrome.


