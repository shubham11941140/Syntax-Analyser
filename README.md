# Syntax-Analyser
Checks syntax of C code (subset of C language) using Lex and Yacc


Compile the code with the following commands on Linux Terminal:
bison -d syntax.y
flex lex.l
gcc syntax.tab.c lex.yy.c
./a.out 

Enter the string to check syntax
OR
./a.out < Input_File.c 
To check syntax of the whole file
