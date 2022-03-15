### Our simple CFG again: Balanced parens
### Our simple CFG again: Balanced parens

In the following grammar, we remove the simple terminal symbol: a, and replace
it with: Eps, or Epsilon.

```bnf
<S> ::= "(" <S> ")"
        | Eps
```

The above grammar now recognizes :

- "" : The empty string, - ()- (())- ((()))