:-[codigo_comum].


conta_var(Lista, Num_var) :-
    include(var, Lista, Lista_so_com_var),
    length(Lista_so_com_var, Num_var).


aplica_R1_triplo(Lista, Lista) :-
    conta_var(Lista, X),
    X >= 2,
    !.


aplica_R1_triplo(Lista, Lista) :-
    conta_var(Lista, 0),
    \+member(Lista, [[0,0,0], [1,1,1]]), !.



aplica_R1_triplo(Lista, Lista) :-
    conta_var(Lista, 1),
    exclude(var, Lista, Lista_sem_var),
    member(Lista_sem_var, [[0,1], [1,0]]), !.


aplica_R1_triplo(Lista_original, Nova_lista) :-
    conta_var(Lista_original, 1),
    copy_term(Lista_original, Lista),
    Nova_lista = Lista,
    member(Nova_lista, [
        [0,0,1],
        [0,1,0],
        [0,1,1],
        [1,0,0],
        [1,0,1],
        [1,1,0]]), !.



aplica_R1_fila_aux([H0, H1, H2], T):-
            !,
            aplica_R1_triplo([H0, H1, H2], T).



aplica_R1_fila_aux([H0, H1, H2 | T], [X | Cauda]):-
            aplica_R1_triplo([H0, H1, H2], [X, Y, Z]),
            aplica_R1_fila_aux([Y, Z | T], Cauda).



% Se duas listas sao iguais
iguais(L1, L2) :-
    conta_var(L1, X), 
    conta_var(L2, Y),
    X == Y,
    L1 = L2.



% Case contrario vamos aplicar r1 fila aux.
aplica_R1_fila(Fila, N_fila) :-
                aplica_R1_fila_aux(Fila, N_fila_aux),
                not(iguais(Fila, N_fila_aux)), !,
                aplica_R1_fila(N_fila_aux, N_fila).




aplica_R1_fila(Fila, Fila_mod) :-
        aplica_R1_fila_aux(Fila, Fila_mod),
        iguais(Fila, Fila_mod), !.



% Res eh o numero de uns na lista
conta_1(Lista, Res) :-
    include(==(1), Lista, Lista_filtrada),
    length(Lista_filtrada, Res).

conta_0(Lista, Res) :-
    include(==(0), Lista, Lista_filtrada),
    length(Lista_filtrada, Res).




aplica_R2_fila_aux(_, X, X) :- nonvar(X).
aplica_R2_fila_aux(Novo_valor, X, Novo_valor) :- var(X).





aplica_R2_fila(Fila, Fila_mod) :-
                        conta_0(Fila, N),
                        %writeln(N),
                        length(Fila, M),
                        %writeln(M),
                        M is 2*N,
                        %writeln("Metade sao zeros"),
                        maplist(aplica_R2_fila_aux(1), Fila, Fila_mod).




aplica_R2_fila(Fila, Fila_mod) :-
                        conta_1(Fila, N),
                        %writeln(N),
                        length(Fila, M),
                        %writeln(M),
                        M is 2*N,
                        %writeln("Metade sao zeros"),
                        maplist(aplica_R2_fila_aux(0), Fila, Fila_mod).


aplica_R2_fila(Fila, Fila) :-
                        conta_0(Fila, N0),
                        conta_1(Fila, N1),
                        length(Fila, Len),
                        2*N0 < Len,
                        2*N1 < Len.


aplica_R1_R2_fila(Fila, Fila_mod) :-
                    %escreve_Linha(Fila),
                    aplica_R1_fila(Fila, Fila_tmp),
                    aplica_R2_fila(Fila_tmp, Fila_mod).


% Aplica a cada linha e a cada coluna R1 e R2
aplica_R1_R2_puzzle(Puz, N_Puz) :-
        maplist(aplica_R1_R2_fila, Puz, Tmp1),
        mat_transposta(Tmp1, Tmp2),
        maplist(aplica_R1_R2_fila, Tmp2, Tmp3),
        mat_transposta(Tmp3, N_Puz).




igual(X, X) :- var(X).
igual(0, 0).
igual(1, 1).


listas_iguais([], []).

listas_iguais([H1|R1], [H2|R2]):-
    igual(H1, H2),
    listas_iguais(R1, R2).



/* Basta aplicar 2n vezes R1 e R2 a todas as linhas e colunas do puzzle,
 * em que n e o numero de linhas da matriz puzzle */
inicializa(Puz, N_puz) :-
                length(Puz, N),
                N_dobro is N * 2,
                inicializa_aux(Puz, N_puz, N_dobro).


%Caso terminal
inicializa_aux(N_puz, N_puz, 0).

inicializa_aux(Puz, N_Puz, N) :-
            aplica_R1_R2_puzzle(Puz, N_P),
            N_menos_1 is N - 1,
            inicializa_aux(N_P, N_Puz, N_menos_1).

/*
% Verdade sse X ocorre apenas uma unica vez em Li.
ocorrencia_unica(Li, X) :-
    include(==(X), Li, Lista_so_com_X),
    length(Lista_so_com_X, 1).


% Se todos os elementos da lista sao unicos
nao_repetidos(Li) :- maplist(ocorrencia_unica(Li), Li).

verifica_R3(Puz_original) :-
            copy_term(Puz_original, Puz),
            transpose(Puz, Puz_T),
            maplist(nao_repetidos, Puz),
            maplist(nao_repetidos, Puz_T).
*/

