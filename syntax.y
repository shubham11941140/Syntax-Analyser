%{
#include<string.h>
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror();
int pdte=0;
int ie=0;
int ee=0;
int opening=0;
int closing=0;
int comma=0;
int number_of_kernal=0;
int number_in_e=0;
int kcalled=0;
int ecalled=0;
int global_called=0;
int pdtd=0;
int semicolon=0;
int opening_curly_braces=0;
int closing_curly_braces=0;
int ij=0;
int oj=0;
int else_called=0;
int before_for=0;
int opening_for=0;
int semicolon_for=0;
int equal_to_in_for=0;
int operator_in_for=0;
int pdtf=0;
int sdf=0;
%}

%token KERNEL_FUNCTION KERNEL_INVOCATION PRIMITIVE_DATA_TYPE DERIVED_DATA_TYPE CONSTANT_KEYWORD SIMPLE_STATEMENT
%token OPERATOR CONTROL_FLOW FOR_ IF_ COMMA CLOSING OPENING EQUAL_TO IDENTIFIER SPECIAL_CHARACTER COLON
%token PROGRAMMER_DEFINED_FUNCTION SYSTEM_DEFINED_FUNCTION PRE_PROCESSOR_DIRECTIVE SINGLE_LINE_COMMENT
%token MULTI_LINE_COMMENT SEMICOLON OPENING_CURLY CLOSING_CURLY COJ ELSE_

%left '+'

%%

CODE: E
{
	if (ecalled==1 
			&& kcalled==1)
	{
        printf("Error! Invalid Syntax before kernal funciton.\n");
		return 0;
	}
    if (pdte==1)
	{
        if (ee>comma+1)
		{			
            printf("Error! Lot of equal to sign\n");
            return 0;
		}
		else
		{
            goto aaa;
        }
    }
	if (ee>1)
	{
        printf("Error! Lot of equal to sign\n");
        return 0;
    }
    if (comma>=1)
	{
        printf("Error! Lot of commas\n");
		return 0;
	}        
    if (opening!=closing)
	{
        printf("Error! Unbalanced parenthises.\n");
        return 0;
    }
    aaa:
    printf("NO ERROR\n");
    return 0;
}      

E : SEMICOLON 
{
	ecalled=1;
	before_for++;
}
  | IDENTIFIER  
{
	ie++;
	ecalled=1;
	before_for++;
} E
  | EQUAL_TO  
{
	ee++;
	ecalled=1;
	before_for++;
} E
  | PRIMITIVE_DATA_TYPE   
{
	pdte++;
	ecalled=1;
	before_for++;
	if (pdte==2)
	{
		printf("Error! More then 1 primitive data type.\n");
		return 0;
	}
} E
  | OPERATOR  
{
	ecalled=1;
	before_for++;
} E
  | OPENING  
{
	opening++;
	ecalled=1;
	before_for++;
} E
  | CLOSING  
{
	closing++;
	ecalled=1;
	before_for++;
} E
  | COMMA  
{
	comma++;
	ecalled=1;
	before_for++;
} E
  | KERNEL_INVOCATION 
{
	ecalled=1;
	global_called=1;
	before_for++;
} E
  | K
  | IF_ J
  | ELSE_ 
{
    else_called=1;
    if (ecalled==1)
	{
        printf("Error! Invalid syntax before else keyword.\n");
        return 0;
    }
}
  | FOR_ 
{
	if (before_for!=0)
	{
		printf("Error! Invalid syntax before for keyword.\n");
		return 0;
    }
} F
  | SINGLE_LINE_COMMENT
  | MULTI_LINE_COMMENT
  | PRE_PROCESSOR_DIRECTIVE 
{	
    if (ecalled==1)
	{
		printf("Error! Invalid syntax before preprocessor directive.\n");
		return 0;
    }
}
  | SYSTEM_DEFINED_FUNCTION S;


K : SEMICOLON 
{
	kcalled=1;
}
  | KERNEL_FUNCTION 
{
	number_of_kernal++;
	if (number_of_kernal>=2)
	{
		printf("Error! found more then 1 kernal function at the same time.\n");
		return 0;
	}
	if (number_of_kernal==1 
			&& global_called==1 
				&& pdte==1)
	{
        printf("NO ERROR\n");
        return 0;
    }
    if (global_called==1 
			&& pdte>=2)
	{
        printf("Error! More then 1 primitive data type.\n");
    }
} K

J : CLOSING 
{
    closing_curly_braces++;
    if (ecalled==1)
	{
		printf("Error! Invalid syntax before if or while statement.\n");
		return 0;
    }
    if (closing_curly_braces!=opening_curly_braces)
	{
      	printf("Error! Number of opening curly braces and closing curly braces are not same.\n");
      	return 0;
    }
    if (oj>ij)
	{
      	printf("Error! Too many operators found.\n");
      	return 0;
    }
}
  | OPENING 
{
	opening_curly_braces++;
} J
  | IDENTIFIER 
{
	ij++;
}J
  | OPERATOR 
{
	oj++;
}J
  | IF_
{
    printf("Error! More then 2 conditions at the same time.\n");
    return 0;
}

F : OPENING
{
	opening_for++;
    if (opening_for==2)
	{
      	printf("Error! Too many opening parenthises.\n");
      	return 0;
    }
} F
  | IDENTIFIER F
  | EQUAL_TO
{
	equal_to_in_for++;
} F
  | SEMICOLON 
{
	semicolon_for++;
}F
  | CLOSING
{
    if (semicolon_for>=3)
	{
        printf("Error! found %d semicolon expected 2.\n",semicolon_for);
        return 0;
	}
    if (operator_in_for==0)
	{
        printf("Error! 0 operator.\n");
        return 0;
    }
    if (pdtf>=2)
	{
        printf("Error! Found 2 or more primitive data type.\n");
        return 0;
    }
    if (equal_to_in_for==0)
	{
        printf("Error! 0 equal to found.\n");
        return 0;
    }
}
  | PRIMITIVE_DATA_TYPE 
{
	pdtf++;
}F
  | OPERATOR
{
	operator_in_for++;
} F

S : SEMICOLON
{
    if (ecalled==1)
	{
      	printf("Error! Invalid syntax before system defined function.\n");
      	return 0;
    }
    if (sdf>=1)
	{
      	printf("Error! More then 1 system defined function at the same time.\n");
      	return 0;
    }
}
  | SYSTEM_DEFINED_FUNCTION 
{
    sdf++;
} S
  | OPENING S
  | IDENTIFIER S
  | CLOSING S

%%

void main()
{
	printf ("Enter Code Snippet: \n");
  	yyparse();
}

void yyerror()
{
	printf ("Oops error found!\n");
}
