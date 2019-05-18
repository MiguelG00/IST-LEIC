# Projecto 2 - IAED 2018/19

## Autor: Bernardo Mota ist193693 LEIC-T


Este projecto visa implementar um tipo de dados e operações básicas para 
armazenar e procurar dados eficientemente.

Para isso foi utilizada uma tabela de dispersão que tem ponteiros
que garantem que a ordem de inserção é preservada quando queremos
aceder a todos os elementos.

Este tipo abstracto de dados é genérico na medida em que aceita
outro tipo de dados. Para tal foi convencionado que cada tipo deve ter
um destructor (pontiero para função) que garante que toda a memória
relacionada com esse tipo seja libertada.


Este código segue os coding standards do LLVM para identação.

Este código está dividido modularmente em ficheiros. Cada par .c .h é análogo
a uma classe com "atributos" definidos numa struct e métodos que operam
sobre esse tipo.

-----------------------------------------------------------------------------
O código fonte deste sofware inclui uma cópia da função strdup que
apesar de estar disponível na glibc não vem incluida
com a opção de compilação -ansi.

Esta função obviamente não foi implementada peloaluno e como tal a sua
utilização está sujeita a aceitação da licença GPLv2.

O código inclui também uma função de hashing, hashU, que não foi
implementada pelo aluno. Este código é igual a material
apresentado em aulas teóricas de IAED. Esta escolha deve-se a
motivos de eficiência, o aluno não consegiu descobrir e implementar
um algoritmo de hashing seu com menos colisões e mais eficiente.
