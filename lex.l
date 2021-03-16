%{
#include<stdio.h>
#include<stdlib.h>
#include "syntax.tab.h"
extern int yylval;
%}

%%

"__global__" {return KERNEL_INVOCATION;}

[a-zA-z0-9_]*+"<<<"+[0-9]+","+[0-9]+">>>"+"("+([a-zA-z0-9_])+")" {return KERNEL_FUNCTION;}

[a-zA-z0-9_]*+"<<<"+[0-9]+","+[0-9]+">>>"+"("+([a-zA-z0-9_]*+","+[a-zA-z0-9_]*)*+")" {return KERNEL_FUNCTION;}

"int"|"float"|"long int"|"long long int"|"double"|"char"|"void" {return PRIMITIVE_DATA_TYPE;}

("array")|("struct")|("union") {return DERIVED_DATA_TYPE;}

"(" {return OPENING;}

")" {return CLOSING;}

("const") {return CONSTANT_KEYWORD;}

">>>"|"->" {return OPERATOR;}

"=" {return EQUAL_TO;}

"{" {return OPENING_CURLY;}

"}" {return CLOSING_CURLY;}

"," {return COMMA;}

"+"|"-"|"*"|"/"|"="|"=="|"!="|">"|">="|"<"|"<="|"%"|"&&"|"||"|"^"|"!" {return OPERATOR;}

("break")|("return")|("continue") {return SIMPLE_STATEMENT;}

("if")|("while") {return IF_;}

("else") {return ELSE_;}

"for" {return FOR_;}

("switch")|("while")|("for")|("do-while") {return CONTROL_FLOW;}

("printf(")|("scanf(") {return SYSTEM_DEFINED_FUNCTION;}

[a-zA-Z_][a-zA-Z0-9_]+"(" {return SYSTEM_DEFINED_FUNCTION;}

("#include")|("#define") {return PRE_PROCESSOR_DIRECTIVE;}

"//".*" "* {return SINGLE_LINE_COMMENT;}

"/*"([^*]|(\*+[^*/]))*\*+\/ {return MULTI_LINE_COMMENT;}

[a-zA-Z][0-9]+|[a-zA-Z]* {return IDENTIFIER;}

"#"|"@"|"!"|"$" {return SPECIAL_CHARACTER;}

";" {return SEMICOLON;}

":" {return COLON;}

[0-9]* {return IDENTIFIER;}

.|\n ;

%%
int yywrap()
{
    return 1;
}
