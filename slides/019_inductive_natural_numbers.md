
---

### inductive_natural_numbers

A natural number can be defined inductively as a natural number followed by a digit.
Notice the use of recursion in this statement and the following BNF.

```bnf
<S> ::=  <NaturalNumber>
<NaturalNumber> ::= <NaturalNumber> <Digit>
                    | <Digit>
<Digit> ::= "0" | "1" | "2" |" 3" | "4" 
            | "5" | "6" |" 7" | "8" | "9"
```
