# calculator-using-Lex-and-Yacc
Arithmetic Calculator with Lex & Yacc

This project implements an arithmetic calculator using Lex (Flex) for lexical analysis and Yacc (Bison) for syntax parsing. The calculator performs operations on floating-point numbers and supports basic arithmetic operations, exponentiation, and error handling.

Project Design:

Lex (Flex): Responsible for tokenizing the input, breaking it down into meaningful units such as numbers, operators, and parentheses.
Yacc (Bison): Handles the parsing of tokens and applies the necessary grammar rules to evaluate expressions.
Operator Precedence: The calculator ensures that operators follow the correct precedence and associativity, adhering to standard arithmetic rules.
Error Handling: The program includes mechanisms to detect invalid inputs, handle division by zero, and identify mismatched parentheses.
Exponentiation: Exponentiation is supported through the use of the pow() function from the C standard library (math.h).
Output Formatting: The calculator displays results in a readable format, ensuring integers appear without decimals and floating-point numbers are rounded to two decimal places for clarity.

1 Compile the Code
Make sure flex and bison are installed, then run:

lex calculator.l yacc -d calculator.y gcc lex.yy.c y.tab.c -o calculator -lm

2 Run
./calculator

Ece Eker 221101075
