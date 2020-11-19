Functional EvalExpr
===

Time:       3 weeks

Team:       1

Language:   Haskell


The project
----
The goal of this project is to implement a functional **EvalExpr**, that is able to parse a string given as argument and display the resulting value, followed by a new line.

> The output must always have two digits after the decimal points. For instance `1.00`, `3.14`, `4.50`, `0.67`.

Your program must handle **float numbers**, **parentheses** and the following binary operators:
* **sum** (+) and **difference** (-)
* **product** (*) and **division** (\\)
* **power** (^)

> The list above is sorted by precedence, from lower to higher.

#### Stack

[**Stack**](https://docs.haskellstack.org/en/stable/README/) is a convenient **build tool/package manager** for Haskell. Its use is required for this project, with **version 2.1.3** at least.
It wraps a build tool, either **Cabal** or **hpack**.

> You must provide a **Makefile** that builds your stack project (i.e. it should at some pointcall ‘stack build’).

## USAGE *(examples)*:

```
>> ./funEvalExpr "3 + 5.34"
8.34
>>./funEvalExpr “(0.345+ 5 )*( -2-1) / 3"
-5.35
```

Author [**Corentin COUTRET-ROZET**](https://github.com/sheiiva)