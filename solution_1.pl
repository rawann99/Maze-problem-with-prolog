parent(mohamed,ali).
parent(emad,anas).
male(mohamed).
male(emad).
father(X,Y):-
    parent(X,Y),
    male(X).

mother(X,Y):-
    parent(X,Y),
    female(X).
power(X, 1, X).
% If the power was even
power(X, Y, Output):-
    0 is Y mod 2,
    Y2 is integer(Y/2),
    power(X, Y2, Output2),
    Output is Output2 * Output2.
rainy(s).
rainy(r).
cold(r).
snowy(X):-
    rainy(X),
    cold(X).

move(a,b).
move(a,g).
move(b,c).
move(b,h).
move(h,o).
move(c,d).
move(d,j).
move(d,i).
move(j,r).
move(i,p).
move(p,q).
move(g,l).
move(g,f).
move(l,s).
move(r,hall).
move_recursive( A, B, [A,B]):-
    move( A, B ).
move_recursive( A, B ,[A|Route2]):-
    move( A, X ),
    move_recursive( X, B,Route2 ).
get(A,B,L):-
    get2(A,B,[],L).
get2(A,B,Alreadydone,[X|L]):-
    move_recursive(A,B,X),
    not(member(X,Alreadydone)),
    get2(A,B,[X|Alreadydone],L),!.
get2(_,_,_,[]).