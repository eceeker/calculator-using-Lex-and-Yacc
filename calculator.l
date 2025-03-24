%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

int yywrap() { return 1; }
extern int has_error;
%}

%%

[0-9]+(\.[0-9]+)?  { yylval.value = atof(yytext); return NUMBER; }
"("                { return LEFT_PAREN; }
")"                { return RIGHT_PAREN; }
"+"                { return PLUS; }
"-"                { return MINUS; }
"*"                { return TIMES; }
"/"                { return DIVIDE; }
"^"                { return POWER; }
\n                 { return '\n'; }
[ \t]              { /* Boşlukları yoksay */ }
. { 
    printf("Hata: Tanınmayan karakter '%s'! Geçerli bir ifade girin.\n", yytext);
    has_error = 1; 
}

%%