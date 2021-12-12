/*Definition Section*/
%{
#include<stdio.h>
%}
/*Rule Section*/
%%

"auto"|"double"|"int"|"struct"|"break"|"else"|"long"|"switch"|"case"|"enum"|"register"|"typedef"|"char"|"extern"|"return"|"union"|"continue"|"for"|"signed"|"void"|"do"|"if"|"static"|"while"|"default"|"goto"|"sizeof"|"volatile"|"const"|"float"|"short"|"printf" {printf("%s\tKEYWORD\n",yytext);} 						
"{"|"}"|";"|","|"("|")"   {printf("%s\tSEPERATOR\n",yytext);}	
[0-9]* {printf("%s\t Number \n",yytext);}					

"+"|"-"|"/"|"="|"*"|"%"   {printf("%s\tOPERATOR\n",yytext);}						
[a-zA-Z][0-9]+|[a-zA-Z]* {printf("%s\tIdentifier\n",yytext);}    

.|\n ; 												
%%

/*call the yywrap function*/
int yywrap()								
{
return 1;
}
/*Auxiliary function*/
/*Driver function*/

int main(void)
{
/*call the yylex function.*/
printf("Enter String \n");
yylex();
return 0;
}