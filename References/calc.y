%{ 
   /* Definition section */
  #include<stdio.h> 
  int flag=0; 

%}

%start AE 
%token NUMBER 

%left '+' '-'

%left '*' '/' '%' 

%left '(' ')'

 
/* Rule Section */
%% 
  
AE: E{ 
  
         printf("\nResult=%d\n", $$); 
  
         return 0; 
          } 
 E:E'+'E {$$=$1+$3;} 
  
 |E'-'E {$$=$1-$3;} 
  
 |E'*'E {$$=$1*$3;} 
  
 |E'/'E {$$=$1/$3;} 
  
 |E'%'E {$$=$1%$3;} 
  
 |'('E')' {$$=$2;} 
  
 | NUMBER {$$=$1;}
  
%% 
  
//driver code 
void main() 
{ 
  printf("\nEnter Any Arithmetic Expression which can have operations Addition, Subtraction, Multiplication, Division, Modulus and Round brackets:\n"); 
  
   yyparse(); 
   if(flag==0) 
   printf("\nEntered arithmetic expression is Valid\n\n"); 
} 
  
void yyerror() 
{ 
   printf("\nEntered arithmetic expression is Invalid\n\n"); 
   flag=1; 
} 