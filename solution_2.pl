

move(b,a).
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
move(p,end).
move(end,home).

%general algorithm

%query of user and takes start state and next state
go(Start,Goal):-
  path([[Start,null]],[],Goal).

%main predicate that takes open list, closed list and goal state
path([],_,_):-
  write('No solution'),nl,!.
path([[Goal,Parent] | _], Closed, Goal):-
  write('A solution is found'), nl ,
  printsolution([Goal,Parent],Closed),!.
path(Open, Closed, Goal):-
  removeFromOpen(Open, [State, Parent], RestOfOpen),
  getchildren(State, Open, Closed, Children),
  addListToOpen( RestOfOpen,Children  , NewOpen),
  path(NewOpen, [[State, Parent] | Closed], Goal).

%gets Children of State that aren't in Open or Close
getchildren(State, Open ,Closed , Children):-
  bagof(X, moves( State, Open, Closed, X), Children), ! .
getchildren(_,_,_, []).

%adds children to open list (without head child) to form new open list
%here it is like append i.e.Breadth First
addListToOpen(Children, [], Children).
addListToOpen(Children, [H|Open], [H|NewOpen]):-
  addListToOpen(Open, Children ,  NewOpen).

%gets head of open list to get its children later
removeFromOpen([State|RestOpen], State, RestOpen).

%gets next state given the current state
moves( State, Open, Closed,[Next,State]):-
  move(State,Next),
  \+ member([Next,_],Open),
  \+ member([Next,_],Closed).

%prints the path from start state to goal state
printsolution([State, null],_):-
  write(State),nl.
printsolution([State, Parent], Closed):-
  member([Parent, GrandParent], Closed),
  printsolution([Parent, GrandParent], Closed),
  write(State),nl.