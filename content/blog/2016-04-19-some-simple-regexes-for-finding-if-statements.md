---
author: Chris Pilkington
tags:
- bash
date: "2016-04-19T22:37:31Z"
id: 440
title: Some Simple Regexes for Finding If Statements
---

I know almost nothing about regexes, these are just some useful ones I created for checking code style, if statements specifically.

Find single line if statements (Useful when your coding style requires adding curly braces to everything):

```bash
/^ *if \(.+\).*(;)/igm
```

[regex101](https://regex101.com/r/yC1cR5/3)

Find multiple line if statements (Useful when your coding style favours less lines):

```bash
/^ *if \(.+\).*({)/igm
```

[regex101](https://regex101.com/r/lH3tM3/1)

Regex101 is really impressive. You can paste a regex and check it against some test inputs. The best part is the description of what each symbol in your regex does and even what some of the combined parts do, such as various brackets around groups of expressions.