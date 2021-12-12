%{
#include<stdio.h>
int vowel=0;
int cons=0;
%}
%%

"a"|"e"|"i"|"o"|"u"|"A"|"E"|"I"|"O"|"U" {vowel++;}
[a-zA-z] {cons++;}
[\n] {return 0;}
%%
int yywrap()
{
return 1;
}
main()
{
printf("Enter String\n");
yylex();
printf("vowel=%d and Consonent=%d",vowel,cons);
}
