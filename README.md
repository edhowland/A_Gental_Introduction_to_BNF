# A Gentle Introduction to Backus Naur Form

## Abstract

This presentation was originally given to the March 2022 meeting of the
South Eastern Michigan BSD User's Group on 03/15/2022

## Agenda

1. Quick Intro
2. Short Bio of Ed Howland
3. History
4. Usages of BNF in practice
5. Varieties of BNF notation
  * classic BNF
  * EBNF - Extended BNF
  * ABNF - Augmented BNF
  * Notational differences between these
6. Syntax of  BNF
7. What is Language
  * Lexical
  * Grammatical
  * Semantic
8. Types of languages
  * Chomsky hierarchy
  * Regular languages / Reg
  * Context Free Languages
9. Types of Context Free Grammars
  * LL(k)
  * LR(k)
10. Simple example : Regular Expressions
  * Empty RE
  * 1-Character RE
  * Concatenation of 2 REs
  * Alternation of 2 REs
  * Kleene * (Repitition) of RE
    + First use of Recursion
11.  Simple of CFG





## Detailed Venn Diagram of Grammar types

Contained inside Context Free Grammars are:



Linear grammars
Within linear grammars are two proper subsets:

1. Left linear grammars
2. Right linear grammars

Regular grammars are in these 2 subsets.

Another  type of linear grammar is the balanced parens example.

IOW: A to the n B to the n, where n >= 0

```BNF
<S> ::= "(" S ")"
  | Eps
```

The above grammars match all these strings:

"", "()", "(())", "((()))", "(((())))", ...

The above grammar is the canonical "Hello World" of CFGs.

## Regular languages

### Inductive list: Natural numbers

A natural number can be defined in BNF inductively by prepending  the rule to itself
before a single digit:

```BNF
<S> ::= <S> <Digit>
<Digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
```



## Types of Context Free Grammars

There are 2 common types of CFGs: "LL(K)" and "LR(K)".
A complete list would also contain "RR(K)" and "RL(K)".

The meaning of the letters in the acronym:

- "L" : Left to right scanning of the input string.
- Derivation type
  * "L" : Left most derivation
  * "R" : Right most derivation
- "(K)" : The K in the parens is the count of tokens of look-ahead to choose between alternates.




### Association between Grammars and Parsers

A grammar is said to be either LL(K) or LR(K) depending on what type of parser
can be constructed from it. 

### LL(k) Grammars

A grammar that is is LL(K) is one where a LL(K) parser can be constructed
from it. A LL(K) parser is said to be a top-down parser.

### Problems with LL(K) parsers

#### Direct left recursion

```BNF
<S> ::= <S> a
``` 

Using a top down approach here will result in infinite recursion or a stack overflow
if using a recursive descent parser.

To fix this, replace direct left recursion with a new rule
which uses an alternative and right recursion and  Epsilon:

```BNF
<S> ::= <S-Prime>
<S-Prime> ::= a <S-Prime>
  | Eps
```


#### Indirect left recursion

```BNF
<S> ::= <W> <Y> x
<W> ::= <Y> z
<Y> ::= <S> foo
```

Eventually, S will be replaced with W which willbe replaced by Y which will finally be replaced by S.
Resulting in left recursion again.


The strategy for this is to introduce more intermediate new rules which eventually
lead to a form of the type: S goes to S {Beta}
Wherein, the above strategy to replace direct left recursion can be employed.
### LR(K) Grammar

A LR(K) grammar is one that can be used to construct a bottom-up parser.

### Paper from Donald Knuth (1965)

[https://web.archive.org/web/20120315152151/http://www.cs.dartmouth.edu/~mckeeman/cs48/mxcom/doc/knuth65.pdf](https://web.archive.org/web/20120315152151/http://www.cs.dartmouth.edu/~mckeeman/cs48/mxcom/doc/knuth65.pdf)


### Top down parsers

A top down parser starts with the start non terminal symbol and proceeds
to alternately consume and terminal tokens and expand non terminals as each rule
in the grammar is encountered.
A derivation tree (CST/Parse tree) is constructed from the root down
finished in only terminals as leaves of the tree.
Each non terminal on the left side of a rule in the grammar is said to "produce"
a sequence of terminals or non terminals which are called productions.


LL(1) parsers are popular in programming language parsers because they can be
constructed with a recursive descent parser (RDP).

### Bottom up parsers

A bottom up parser constructs the derivation  tree (CST/parse tree) in reverse.
Terminal tokens are consumed and stacked until a non terminal can be constructed.
The process continues building up higher inner non terminal nodes in the tree
until only the root non terminal is reached.
In a LR(K) parser, the direction of the arrow between the LHS and the RHS of a rule
is reversed. Each rule is said to take a list of terminals and non terminals
and reduce them into a LHS non terminal. Therefore, each RHS of a rule is said
to be called a "reduction".


LR(1) parsers are mostly constructed with parser generators like YACC or Bison and their cousins.
These are often called shift/reduce parsers and driven by a lookup table
constructed by the above parser generators from a formal grammar, often similar to 
BNF notation. {YACC Syntax}

#### Shift/Reduce

- Shift : Push(1 Token) on the stack
- Reduce : Pop (N items from stack), Push (1 Non terminal onto the stack.

A YACC-like parser generator will attempt to construct a lookup table from a BNF-like
language specification.

The cells of this table consists of these 4 types of actions.

1. Shift: Push 1 terminal on the stack and goto state X
2. Reduce N : Pop N itemss of the stack, push the LHS non terminal onto the stack. and goto State Y
3. Accept : Accept the entire string as correct. Parsing stops.
4. Error : Reject the string as incorrect. Parsing stops.

Ambiguous grammars can result in errors when constructing the lookup table
by a YACC-like parser generator. These are called  shift/reduce conflicts
or Reduce/Reduce conflicts.
While building the table, a determination on whether to place a Shift action or
Reduce action can not be made. This is usually a warning and the default
will be to place a shift action.

Reduce/Reduce errors are caused by  having the exact sequence of terminals and
non terminals in 2 or more rules. The lookup table maker cannot determine
whether which  LHS non terminal of  of rule 1 or rule 2 to place at that 
position in the table.


LR(K) parsers can parse a larger range of of CFGs than LL(K).

## Glossary

### Sentence

A string of tokens that make up a complete instance of a string in a language L.
Computer source files are examples of sentences.

### Sentential form

A part of or complete expanse of a sentence.
A sentitial form is any part of a string that can be derived from the start symbol
of the language's grammar.
A  Sentential form consists of any terminal or non terminals after 0 or more steps
in the derivation has occurred. The final Sentential form is the input sentence
after the  entire derivation has occurred and consists of only terminal symbols.

### Derivation

A sequence of non terminal expansions that begins with the starting non terminal
and finishes with a Concrete Syntax/Parse tree where the leaves are all the 
terminals in the input string.

### Non terminal

A name of a rule that consists of one or more productions. {See Production}
A non terminal must be expanded into one of its possible productions when
deriving a string in the language.

### Terminal

A string or token in the language that cannot be further expanded.
Terminals form the leaves of derivation trees. Terminals can occur in the RHS
of a production, but cannot occur in the LHS of a rule.

### Production

A production is the RHS of a rule and can consistof one or more of terminals or
non terminals. A rule can have one or more alternate productions.

### Rule

A rule in a grammar consists of a non terminal, an delimiter and one or more
productions. {CFG and Regular grammars}

### Grammar

A grammar {in BNF notation} consists of one or more rules. A grammar must
also indicate the start symbol of the grammar. This might be inferred if the first
rule in the BNF document is the start symbol.

## References

BNF: An overiview
Historical notes and BNF syntax descriptions
[https://www.sciencedirect.com/topics/computer-science/backus-naur-form](https://www.sciencedirect.com/topics/computer-science/backus-naur-form)

History and background of BNF from Wikipedia.org
[https://en.wikipedia.org/wiki/BackusNaur_form](https://en.wikipedia.org/wiki/BackusNaur_form)

What are rewriting systems?
[https://en.wikipedia.org/wiki/Rewriting](https://en.wikipedia.org/wiki/Rewriting)

What is a "Normal Form" and why is not BNF one?
[https://en.wikipedia.org/wiki/Normal_form_(abstract_rewriting)](https://en.wikipedia.org/wiki/Normal_form_(abstract_rewriting))

Compiler Construction Book. An overview:
[https://www.sciencedirect.com/topics/computer-science/compiler-construction](https://www.sciencedirect.com/topics/computer-science/compiler-construction)

Transactional BNF: Wikipedia.org
[https://en.wikipedia.org/wiki/Translational_BackusNaur_form](https://en.wikipedia.org/wiki/Translational_BackusNaur_form)

[Augemented Backus Naur Form: Wikipedia.org](https://en.wikipedia.org/wiki/Augmented_BackusNaur_form#Comment)

Meta notation for formal language specification
[https://en.wikipedia.org/wiki/Metasyntax#Specific_metasyntax_conventions](https://en.wikipedia.org/wiki/Metasyntax#Specific_metasyntax_conventions)cd sli  


### Chomsky Language Hierarchy

[Wikipedia.org: Chomsky Language Hierarchy](https://en.wikipedia.org/wiki/Chomsky_hierarchy#The_hierarchy)





### Linear bound automatas for recognizing Context Sensitive Languages : CSG

[https://en.wikipedia.org/wiki/Linear_bounded_automaton#Operation](https://en.wikipedia.org/wiki/Linear_bounded_automaton#Operation)


### ABNF
[IETF: RFC 5234](https://datatracker.ietf.org/doc/html/rfc5234)
[W3C BNF  notation for syntax](https://www.w3.org/Notation.html)

### Example of ABNF: Internet Mail: RFC 5322
[https://www.rfc-editor.org/rfc/rfc5322.html](https://www.rfc-editor.org/rfc/rfc5322.html)

### From Matt Might's Blog:

Grammar: The language of Language
[https://matt.might.net/articles/grammars-bnf-ebnf/](https://matt.might.net/articles/grammars-bnf-ebnf/)

BNF Playground
Enter some BNF, check it for correctness. Parse some strings or generate strings.

https://bnfplayground.pauliankline.com

[Chao Xu: Context Free Grammars](https://www.youtube.com/watch?v=XnPQElUMRkg)
[Chao Xu:Finite State Machines](https://www.youtube.com/watch?v=Pt6GBVIifZA)
[Wikipedia.com: Linear Grammars](https://en.wikipedia.org/wiki/Linear_grammar)

LL(K) grammars
[https://en.wikipedia.org/wiki/LL_parser](https://en.wikipedia.org/wiki/LL_parser)

LR(K) Parsers. Includes  LR(k) Grammars:
[https://en.wikipedia.org/wiki/LR_parser](https://en.wikipedia.org/wiki/LR_parser)





Syntax of a YACC source file "*.y"
[https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node16.html](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node16.html)

Lex and YACC theory: Good description of shift/reduce parsers
[https://www.epaperpress.com/lexandyacc/thy.html](https://www.epaperpress.com/lexandyacc/thy.html)

Reduce/Reduce errors in Bison (YACC-like parser generator)
[https://www.gnu.org/software/bison/manual/html_node/Reduce_002fReduce.html](https://www.gnu.org/software/bison/manual/html_node/Reduce_002fReduce.html)

Sentitial form and Sentence (wrt Grammars)
[https://web.cs.wpi.edu/~kal/PLT/PLT2.1.2e.html](https://web.cs.wpi.edu/~kal/PLT/PLT2.1.2e.html)

DavidWelles videos
Use of parsers that use a stack instead of recursive descent

Intro to top down parsering
[https://www.youtube.com/watch?v=nPiBjPNYN6w](https://www.youtube.com/watch?v=nPiBjPNYN6w)

Intro to Bottom up parsing
[https://www.youtube.com/watch?v=JPhxQuSWvE4](https://www.youtube.com/watch?v=JPhxQuSWvE4)


### Language BNF specifications
Algo-60
This also gives a nice definition of the BNF syntax. In this document from
the CDC Algol compiler manual Appendix D BNF is called "Backus Normal Form"
Not nice that they left out Peter Naur.
[http://blackbox.userweb.mwn.de/Algol-BNF.html](http://blackbox.userweb.mwn.de/Algol-BNF.html)

Scheme (R5RS)
[https://people.csail.mit.edu/jaffer/r5rs_9.html](https://people.csail.mit.edu/jaffer/r5rs_9.html)

Pascal
[https://condor.depaul.edu/ichu/csc447/notes/wk2/pascal.html](https://condor.depaul.edu/ichu/csc447/notes/wk2/pascal.html)

C
Uses EBNF w/Italics for  nonterminals and bold for terminals.
https://www2.cs.arizona.edu/~debray/Teaching/CSc453/DOCS/cminusminusspec.html

PL/I (I.B.M. 1964)
A version was used as the implementation language for MULTICS
A subset EPL of PLI was used by Doug McIlroy at Bell Labs.
PL/M (DRI) was the first high level programming language for microcomputers.
<No BNF could be found>

Ratfor : Rational Fortram: Brian K, P.J. Plauger
Preprocessor for Fortran/66 control structures from C
https://en.wikipedia.org/wiki/Ratfor#Features

### Python

The full [E]BNF notation for Python version 3.10 can be found at:
[https://docs.python.org/3/reference/grammar.html](https://docs.python.org/3/reference/grammar.html)

It uses a combination of EBNF and PEG notation. One more example of the many
varieties of BNF in the wild!


FORTRAN (I.B.M. 19554)
Although created by team led by John Backus, could not find a BNF for it.


### Ruby

EBNF syntax for Ruby [PDF]
[https://cse.buffalo.edu/~regan/cse305/RubyBNF.pdf]{https://cse.buffalo.edu/~regan/cse305/RubyBNF.pdf}

Ruby still uses Bison, a YACC-like parser generator to create its parser.
Ruby is, therefore, a LR(1) language.

The latest Bison input for Ruby 3.1:
[https://github.com/ruby/ruby/raw/master/parse.y](https://github.com/ruby/ruby/raw/master/parse.y)

### Internet Protocols

Network  News Transfer Protocol
RFC 3977
[https://www.rfc-editor.org/rfc/rfc3977.html#page-90](https://www.rfc-editor.org/rfc/rfc3977.html#page-90)

File Transfer Protocol  FTP
RFC 114

[https://www.rfc-editor.org/rfc/rfc114.html](https://www.rfc-editor.org/rfc/rfc114.html)


### Data or Configuration languages

#### Javascript Object Notation JSON

[https://cswr.github.io/JsonSchema/spec/grammar/](https://cswr.github.io/JsonSchema/spec/grammar/)

## Books

Parsing techniques: A practical guide
[https://www.amazon.com/gp/product/1441919015/ref=as_li_ss_tl?ie=UTF8&tag=mmamzn06-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=1441919015#customerReviews\](https://www.amazon.com/gp/product/1441919015/ref=as_li_ss_tl?ie=UTF8&tag=mmamzn06-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=1441919015#customerReviews)


### The "Dragon" book: Compilers: Principals, Techniques and Tools

Two of its authors, Alfred Aho and Jeffery Ullman, are Turing award winners and also worked at Bell Labs.
[https://www.thriftbooks.com/w/compiladores-principios-tecnicas-y-herramientas_alfred-v-aho/248872/item/1373766/?gclid=Cj0KCQiA09eQBhCxARIsAAYRiylIBhuBwpATDYEeR09nS1W8FaRmCmoMLOiOWbKupGCOpFbbm7N0h5YaAlAhEALw_wcB#TBContent](https://www.thriftbooks.com/w/compiladores-principios-tecnicas-y-herramientas_alfred-v-aho/248872/item/1373766/?gclid=Cj0KCQiA09eQBhCxARIsAAYRiylIBhuBwpATDYEeR09nS1W8FaRmCmoMLOiOWbKupGCOpFbbm7N0h5YaAlAhEALw_wcB#TBContent)

A cheaper version of the original 1986 edition.

Wolfram, S. A New Kind of Science
[https://en.wikipedia.org/wiki/A_New_Kind_of_Science#Computation_and_its_implications](https://en.wikipedia.org/wiki/A_New_Kind_of_Science#Computation_and_its_implications)



Introduction to the Theory of Computation, Sipser, Michael
[https://www.amazon.com/Introduction-Theory-Computation-Michael-Sipser/dp/113318779X](https://www.amazon.com/Introduction-Theory-Computation-Michael-Sipser/dp/113318779X)
## Papers

Turing, Alan M. (1936) On the  Computable Numbers with an application to

The original, and still the best.

PDF: [https://www.cs.virginia.edu/~robins/Turing_Paper_1936.pdf](https://www.cs.virginia.edu/~robins/Turing_Paper_1936.pdf)

Notes about regular sets, regular expressions and regular languages:
[https://www.includehelp.com/toc/regular-sets-and-their-properties-in-theory-of-computation.aspx](https://www.includehelp.com/toc/regular-sets-and-their-properties-in-theory-of-computation.aspx)

Wikipedia article on Thompson Construction (Ken Thompson of Unix Kernel fame)
How to construct an linear time complex algorithm NFA from a regexp:
[https://en.wikipedia.org/wiki/Thompson%27s_construction#The_algorithm](https://en.wikipedia.org/wiki/Thompson%27s_construction#The_algorithm)


Notes from college class on computational models
Extensive notes on LALR(1) parsers
[https://kentdlee.github.io/ComputationalModels/build/html/chap7/index.html](https://kentdlee.github.io/ComputationalModels/build/html/chap7/index.html)

Description of PDAs including a palindrome matcher
[https://www.cs.odu.edu/~zeil/cs390/latest/Public/pushdown/index.html](https://www.cs.odu.edu/~zeil/cs390/latest/Public/pushdown/index.html)

PDAs in Google slides:
[https://docs.google.com/presentation/d/1AEFABA2dypaHVo4m7K74RZhp6Pd9eKakJdFiuIGU42g/htmlpresent](https://docs.google.com/presentation/d/1AEFABA2dypaHVo4m7K74RZhp6Pd9eKakJdFiuIGU42g/htmlpresent)
### Videos

Peter Naur ACM AM Turing award lecture
[https://amturing.acm.org/vp/naur_1024454.cfm](https://amturing.acm.org/vp/naur_1024454.cfm)

Donald Knuth on his love of Context Free Languages
[https://www.webofstories.com/play/donald.knuth/30](https://www.webofstories.com/play/donald.knuth/30)

Computerphile videos on parsing
https://www.youtube.com/watch?v=bxpc9Pp5pZM

Problem with Top down parsing: Left Recursion
https://www.youtube.com/watch?v=ckkzQ_KTFfg

More videos from Developer Zone on Compilers
https://www.youtube.com/playlist?list=PLRnCK4HQiHuTKvA0YI5SYUW5rcwiNR7Oc
Note: Covers most of the items in this talk and expands on them.

Math's Fundamental Flaw
https://www.youtube.com/watch?v=HeQX2HjkcNo



Bottom Up parsing
https://www.youtube.com/watch?v=tH5AOX9929g

Chomsky Normal Form
https://www.youtube.com/watch?v=IiCbNhHwsws
The complete playlist on Theory of Computation from this channel
https://www.youtube.com/playlist?list=PLbtzT1TYeoMjNOGEiaRmm_vMIwUAidnQz

MIT OpenCourseWare Fall 2020 Theory of computation with Michael Sipser
https://www.youtube.com/redirect?event=playlist_description&redir_token=QUFFLUhqblRaazVUb3JxbTFvSnNyMGdpeHVwSHZPckQtZ3xBQ3Jtc0tuU2dYR1VvV01VWWY2V2tZdnNjZVRMYzRFOF9udzJrM3JhbEVxN2kxM0VWQU9tZDRGSGZ1Ync2SXdpRDUzQ0NmVTcxeTcyTXIyTTQ5YzhlVkREY29MY0ZhMnRGcGE1WVZEOWVWVmp2em1Ua1hWaHZfMA&q=https%3A%2F%2Focw.mit.edu%2F18-404JF20
The complete playlist (25 videos)
[https://www.youtube.com/playlist?list=PLUl4u3cNGP60_JNv2MmK3wkOt9syvfQWY](https://www.youtube.com/playlist?list=PLUl4u3cNGP60_JNv2MmK3wkOt9syvfQWY)


With regard to nondeterminism, consider the Unix fork() system call.
It returns 0 in the child process and the PID in the parent process.
https://www.youtube.com/watch?v=xHu7qI1gDPA


### ACM AM Turing Awardees

John Backus: 1977

For profound, influential, and lasting contributions to the design of practical high-level programming systems, notably through his work on FORTRAN, and for seminal publication of formal procedures for the specification of programming languages.


The latter is in recognization of his work on BNF

[https://amturing.acm.org/award_winners/backus_0703524.cfm](https://amturing.acm.org/award_winners/backus_0703524.cfm)

Turing Award lecture
PDF
[https://dl.acm.org/ft_gateway.cfm?id=1283933&type=pdf](https://dl.acm.org/ft_gateway.cfm?id=1283933&type=pdf)
Peter Naur

Dana Scott
Proof that any nondeterministic finite automaton can be turned into a deterministic finite automaton (NFA <=> DFA)
https://amturing.acm.org/award_winners/scott_1193622.cfm

## File formats
YAML
[https://gist.github.com/tociyuki/3936873](https://gist.github.com/tociyuki/3936873)

JSON (Not official, AFAIK)
[https://cswr.github.io/JsonSchema/spec/grammar/](https://cswr.github.io/JsonSchema/spec/grammar/)

## History and Miscellany

I.B.M. Selective Sequence Electronic Calculator. Electro-Mechanical computer)

[https://en.wikipedia.org/wiki/IBM_SSEC](https://en.wikipedia.org/wiki/IBM_SSEC)
