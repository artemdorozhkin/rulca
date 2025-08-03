# RULCA

**Rulca** is a **RU**by ca**LC**ul**A**tor.

Its just a minimal eduactional project built to learn Ruby.

## Features

- No dependencies - pure Ruby.
- Supports `+`, `-`, `*`, `/`, `()`.
- Operator precedence.
- Made with love just for fun and learning.

## Quick start

Make sure you have Ruby installed.

Clone the repo and run:

```console
make
```

Example:

```console
Input expression:
2 + 3 * (4 - 1)
11
Input expression:
exit
```

## Tests

Rulca is covered with tests using Minitest:

```
ruby test/test_calculator.rb
```

You can also test components like the lexer or the parser:

```
ruby test/test_lexer.rb
ruby test/test_parser.rb
```

Or, you can just run it all at once:

```
make tests
```
