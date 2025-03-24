%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
void yyerror(const char *s);
extern FILE *yyin;
extern void yy_scan_string(const char *s);

int has_error = 0;
%}

%union {
    double value;
}

%token <value> NUMBER
%token PLUS MINUS TIMES DIVIDE POWER LEFT_PAREN RIGHT_PAREN

%type <value> expression

%left PLUS MINUS
%left TIMES DIVIDE
%right POWER

%%

input:
    | input expression '\n' {
        if (!has_error) {
            if ($2 == (int)$2)
                printf("Sonuç: %d\n", (int)$2);
            else
                printf("Sonuç: %.5lf\n", $2);
        }
        has_error = 0;
    }
    | '\n'
    ;

expression:
      expression PLUS expression { $$ = $1 + $3; }
    | expression MINUS expression { $$ = $1 - $3; }
    | expression TIMES expression { $$ = $1 * $3; }
    | expression DIVIDE expression {
        if ($3 == 0) {
            printf("Hata: Sıfıra bölme hatası!\n");
            has_error = 1;
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | expression POWER expression { $$ = pow($1, $3); }
    | LEFT_PAREN expression RIGHT_PAREN { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%%

int main() {
    char buffer[256];
    printf("Matematiksel ifadeleri giriniz (çıkış için boş satır bırakın):\n");

    // Test cases
    char *test_cases[] = {
        "3 + 5\n",
        "10 * 4\n",
        "10 *           2\n",
        "6 - 2\n",
        "             6-2\n",
        "8 / 2\n",
        "(1 + 2) * 4\n",
        "(3 + 5) * 2\n",
        "(7 - 2) / 5\n",
        "(3 + (5 - 2)) * 4\n",
        "(3 + 5) * (2 - 1) / 4\n",
        "((3 + 5) * (2 - 1)) / (4 + 2)\n",
        "(10 - (2 * 3)) / (7 - 5)\n",
        "(4 * (2 + 3)) / 5\n",
        "2.5 * 4.2\n",
        "3.1 + 2.9\n",
        "7.5 - 3.5\n",
        "5.5 / 2.2\n",
        "2 ^ 3\n",
        "4 ^ 0.5\n",
        "2 ^ (1 + 2)\n",
        "8 / 0\n",
        "abc\n"
    };

    int num_tests = sizeof(test_cases) / sizeof(test_cases[0]);
    printf("Test vakaları çalıştırılıyor...\n");

    for (int i = 0; i < num_tests; i++) {
        printf("\nTest %d: %s", i + 1, test_cases[i]);
        has_error = 0;

        yyin = fmemopen(test_cases[i], strlen(test_cases[i]), "r");
        yyparse();

        if (has_error) {
            printf("Geçerli bir ifade girin.\n");
        }
    }

    printf("\nÖzel giriş moduna geçiliyor.\n");
    while (1) {
        printf("> ");
        fgets(buffer, sizeof(buffer), stdin);
        
        if (buffer[0] == '\n')
            break;
        
        has_error = 0;
        yyin = fmemopen(buffer, strlen(buffer), "r");
        yyparse();
    }

    printf("Çıkış yapılıyor.\n");
    return 0;
}

void yyerror(const char *s) {
    printf("Hata: Geçersiz ifade! Lütfen operatörleri kontrol edin.\n");
    has_error = 1;
}
